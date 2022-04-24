//
//  ZooHomeHeadCell.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooHomeHeadCell : UICollectionReusableView

- (void)renderUIWithTitle:(nullable NSString *)title;
- (void)renderUIWithSubTitle:(NSString *)subTitle;

@end

NS_ASSUME_NONNULL_END
