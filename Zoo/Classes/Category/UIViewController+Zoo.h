//
//  UIViewController+Zoo.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Zoo)

// safe area inset
- (UIEdgeInsets)safeAreaInset;

// 默认采用view frame | 调整刘海屏 | 支持转向调整
- (CGRect) fullscreen;

// key window root vc
+ (UIViewController *)rootViewControllerForKeyWindow;

// key window top vc
+ (UIViewController *)topViewControllerForKeyWindow;

+ (UIViewController *)rootViewControllerForZooHomeWindow;

@end

NS_ASSUME_NONNULL_END
