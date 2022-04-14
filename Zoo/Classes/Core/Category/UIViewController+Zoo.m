//
//  UIViewController+Zoo.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "UIViewController+Zoo.h"
#import "UIView+Zoo.h"
#import "ZooHomeWindow.h"
#import "ZooUtil.h"

@implementation UIViewController (Zoo)

- (UIEdgeInsets)safeAreaInset:(UIView *)view {
    if (@available(iOS 11.0, *)) {
        return view.safeAreaInsets;
    }
    return UIEdgeInsetsZero;
}

// safe area inset
- (UIEdgeInsets)safeAreaInset {
    return [self safeAreaInset:self.view];
}

// 默认采用view frame | 调整刘海屏 | 支持转向调整
- (CGRect) fullscreen {
    CGRect screen = self.view.frame;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    switch (orientation) {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
        {
            CGSize size = self.view.zoo_size;
            if (size.width > size.height) {
                UIEdgeInsets safeAreaInsets = [self safeAreaInset];
                CGRect frame = screen;
                CGFloat width = self.view.zoo_width - safeAreaInsets.left - safeAreaInsets.right;
                frame.origin.x = safeAreaInsets.left;
                frame.size.width = width;
                screen = frame;
            }
        }
            break;
        default:
        {
            UIEdgeInsets safeAreaInsets = [self safeAreaInset];
            CGRect frame = screen;
            frame.origin.y = safeAreaInsets.top;
            frame.size.height = self.view.zoo_height - safeAreaInsets.top;
            screen = frame;
        }
            break;
    }
    
    return screen;
}

+ (UIViewController *)rootViewControllerForKeyWindow{
    UIWindow *keyWindow = [ZooUtil getKeyWindow];
    return [keyWindow rootViewController];
}

+ (UIViewController *)topViewControllerForKeyWindow {
    UIViewController *resultVC;
    UIWindow *keyWindow = [ZooUtil getKeyWindow];
    resultVC = [self _topViewController:[keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

+ (UIViewController *)rootViewControllerForZooHomeWindow{
    return [ZooHomeWindow shareInstance].rootViewController;
}

@end
