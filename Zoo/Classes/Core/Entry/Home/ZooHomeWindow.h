//
//  ZooHomeWindow.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <UIKit/UIKit.h>

@interface ZooHomeWindow : UIWindow

@property (nonatomic, strong) UINavigationController *nav;

+ (ZooHomeWindow *)shareInstance;

// open plugin vc
+ (void)openPlugin:(UIViewController *)vc;

- (void)show;
- (void)hide;

@end
