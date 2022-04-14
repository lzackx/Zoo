//
//  ZooToastUtil.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooToastUtil.h"
#import "UIColor+Zoo.h"
#import "UIView+Zoo.h"
#import "ZooDefine.h"


@implementation ZooToastUtil

+ (void)showToast:(NSString *)text inView:(UIView *)superView {
    if (!superView) {
        return;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(14)];
    label.text = text;
    [label sizeToFit];
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
    if (@available(iOS 13.0, *)) {
        label.textColor = [UIColor labelColor];
    } else {
#endif
        label.textColor = [UIColor blackColor];
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
    }
#endif
    label.frame = CGRectMake(superView.zoo_width/2-label.zoo_width/2, superView.zoo_height/2-label.zoo_height/2, label.zoo_width, label.zoo_height);
    [superView addSubview:label];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [label removeFromSuperview];
    });
    
}

+ (void)showToastBlack:(NSString *)text inView:(UIView *)superView {
    if (!superView) {
        return;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(28)];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = kZooSizeFrom750_Landscape(8);
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    label.attributedText = [[NSAttributedString alloc] initWithString:ZooLocalizedString(text) attributes:attributes];
    label.numberOfLines = 0;
    CGSize size = [label sizeThatFits:CGSizeMake(superView.zoo_width-50, CGFLOAT_MAX)];
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
    if (@available(iOS 13.0, *)) {
        label.backgroundColor = [UIColor labelColor];
    } else {
#endif
        label.backgroundColor = [UIColor blackColor];
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
    }
#endif
    CGFloat padding = kZooSizeFrom750_Landscape(37);
    label.frame = CGRectMake(superView.zoo_width/2-size.width/2 - padding, superView.zoo_height/2-size.height/2 - padding, size.width + padding*2, size.height + padding*2);
    label.layer.cornerRadius = kZooSizeFrom750_Landscape(8);
    [label.layer setMasksToBounds:YES];
    label.textColor = [UIColor whiteColor];
    [superView addSubview:label];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [label removeFromSuperview];
    });
    
}

@end
