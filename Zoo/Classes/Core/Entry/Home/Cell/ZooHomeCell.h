//
//  ZooHomeCell.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooHomeCell : UICollectionViewCell

- (void)update:(NSString *)image name:(NSString *)name;
- (void)updateImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
