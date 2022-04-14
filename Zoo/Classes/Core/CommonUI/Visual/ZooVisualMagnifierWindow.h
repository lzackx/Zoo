//
//  ZooVisualMagnifierWindow.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooVisualMagnifierWindow : UIWindow

/**
 放大镜的宽高（默认为90）
 */
@property (nonatomic, assign) CGFloat magnifierSize;

/**
 放大倍数（默认2.0）
 */
@property (nonatomic, assign) CGFloat magnification;

/**
 目标视图的Window
 */
@property (nonatomic, strong) UIView *targetWindow;

/**
 目标视图展示位置
 */
@property (nonatomic, assign) CGPoint targetPoint;

@end

NS_ASSUME_NONNULL_END
