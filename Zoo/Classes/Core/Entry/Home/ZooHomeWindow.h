//
//  ZooHomeWindow.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <UIKit/UIKit.h>

@interface ZooHomeWindow : UIWindow

@property (nonatomic, strong) UINavigationController *nav;

+ (ZooHomeWindow *)shareInstance;

// open plugin vc
+ (void)openPlugin:(UIViewController *)vc;

- (void)show;
- (void)hide;

@end
