//
//  ZooHomeHeadCell.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooHomeHeadCell : UICollectionReusableView

- (void)renderUIWithTitle:(nullable NSString *)title;
- (void)renderUIWithSubTitle:(NSString *)subTitle;

@end

NS_ASSUME_NONNULL_END
