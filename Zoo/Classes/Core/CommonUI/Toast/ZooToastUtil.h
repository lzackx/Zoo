//
//  ZooToastUtil.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZooToastUtil : NSObject

+ (void)showToast:(NSString *)text inView:(UIView *)superView;
+ (void)showToastBlack:(NSString *)text inView:(UIView *)superView;

@end
