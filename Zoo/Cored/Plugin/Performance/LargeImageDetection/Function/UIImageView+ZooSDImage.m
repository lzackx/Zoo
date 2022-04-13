//
//  UIImageView+ZooSDImage.m
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#if __has_include(<SDWebImage/UIImageView+WebCache.h>)
#import "UIImageView+ZooSDImage.h"
//#import <SDWebImage/UIImageView+WebCache.h>
#import "NSObject+Zoo.h"
#import "ZooLargeImageDetectionManager.h"
#import <objc/runtime.h>

@implementation UIImageView (ZooSDImage)

+ (void)load {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    BOOL respondToSelector = [UIImageView instancesRespondToSelector:@selector(sd_internalSetImageWithURL:placeholderImage:options:context:setImageBlock:progress:completed:)];
    if (respondToSelector) {
        // 兼容SDWebImage 最新版本 5.0.6
        [self zoo_swizzleInstanceMethodWithOriginSel:@selector(sd_internalSetImageWithURL:placeholderImage:options:context:setImageBlock:progress:completed:)
                                              swizzledSel:@selector(zoo_sd_internalSetImageWithURL:placeholderImage:options:context:setImageBlock:progress:completed:)];
    } else {
        // 兼容SDWebImage 我们使用的版本 3.7.6
        [self zoo_swizzleInstanceMethodWithOriginSel:@selector(sd_setImageWithURL:placeholderImage:options:progress:completed:) swizzledSel:@selector(zoo_sd_setImageWithURL:placeholderImage:options:progress:completed:)];
    }
#pragma clang diagnostic pop
}

- (void)zoo_sd_internalSetImageWithURL:(nullable NSURL *)url
                           placeholderImage:(nullable UIImage *)placeholder
                                    options:(NSUInteger)options
                                    context:(id)context
                              setImageBlock:(id)setImageBlock
                                   progress:(id)progressBlock
                                  completed:(void(^)(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, NSInteger cacheType, BOOL finished, NSURL * _Nullable imageURL))completedBlock {
    
    __weak typeof(self) weafSelf = self;
    if ([ZooLargeImageDetectionManager shareInstance].detecting) {
        id replaceCompletedBlock = ^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, NSInteger cacheType,BOOL finished, NSURL * _Nullable imageURL) {
            if (data.length > [ZooLargeImageDetectionManager shareInstance].minimumDetectionSize) {
                NSString *drawText = [NSString stringWithFormat:@"url : %@ \n size : %fKB",[url absoluteString],data.length/1024.];
                weafSelf.image = [self drawText:drawText inImage:weafSelf.image];
            }
            if (completedBlock) {
                completedBlock(weafSelf.image, data, error, cacheType, finished, imageURL);
            }
        };
        [self zoo_sd_internalSetImageWithURL:url placeholderImage:placeholder options:options context:context setImageBlock:setImageBlock progress:progressBlock completed:replaceCompletedBlock];
    } else {
        [self zoo_sd_internalSetImageWithURL:url placeholderImage:placeholder options:options context:context setImageBlock:setImageBlock progress:progressBlock completed:completedBlock];
    }
}

- (void)zoo_sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(NSUInteger)options progress:(id)progressBlock completed:(void(^)(UIImage *image, NSError *error, NSInteger cacheType, NSURL *imageURL))completedBlock{
    __weak typeof(self) weafSelf = self;
    if ([ZooLargeImageDetectionManager shareInstance].detecting) {
        id replaceCompletedBlock = ^(UIImage *image, NSError *error, NSInteger cacheType, NSURL *imageURL) {
            NSData *data = UIImageJPEGRepresentation(image, 1.0);
            if (!data && data.length <= 0) {
                data = UIImagePNGRepresentation(image);
            }
            if (data.length > [ZooLargeImageDetectionManager shareInstance].minimumDetectionSize) {
                NSString *drawText = [NSString stringWithFormat:@"url : %@ \n size : %fKB",[url absoluteString],data.length/1024.];
                weafSelf.image = [self drawText:drawText inImage:weafSelf.image];
            }
            if (completedBlock) {
                completedBlock(weafSelf.image, error, cacheType,imageURL);
            }
        };
        [self zoo_sd_setImageWithURL:url placeholderImage:placeholder options:options progress:progressBlock completed:replaceCompletedBlock];
    } else {
        [self zoo_sd_setImageWithURL:url placeholderImage:placeholder options:options progress:progressBlock completed:completedBlock];
    }
}

- (UIImage *)drawText:(NSString *)text inImage:(UIImage *)image {
    UIFont *font = [UIFont boldSystemFontOfSize:12 * (image.size.height / 230)];
    UIGraphicsBeginImageContextWithOptions(image.size, NO, [UIScreen mainScreen].scale);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    [image drawInRect:rect];
    [text drawInRect:CGRectIntegral(rect) withAttributes:@{
                                                           NSFontAttributeName : font,
                                                           NSForegroundColorAttributeName : [UIColor redColor]
                                                           }];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end

#endif
