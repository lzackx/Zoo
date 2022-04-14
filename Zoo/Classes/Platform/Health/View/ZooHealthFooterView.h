//
//  ZooHealthFooterView.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZooHealthFooterButtonDelegate<NSObject>

- (void)footerBtnClick:(id)sender;

@end

@interface ZooHealthFooterView : UIView


@property (nonatomic, weak) id<ZooHealthFooterButtonDelegate> delegate;
@property (nonatomic, assign) BOOL top;

- (void)renderUIWithTitleImg:(NSString *)title img:(NSString *)imgName;
- (void)renderUIWithTitleImg:(BOOL)top;

@end

NS_ASSUME_NONNULL_END
