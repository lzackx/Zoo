//
//  ZooColorPickWindow.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <UIKit/UIKit.h>

@interface ZooColorPickWindow : UIWindow

+ (ZooColorPickWindow *)shareInstance;

- (void)show;

- (void)hide;

@end
