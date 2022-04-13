//
//  ZooViewMetricsManager.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZooViewMetricsConfig : NSObject

@property (nonatomic, strong) UIColor *borderColor;     //default randomColor
@property (nonatomic, assign) CGFloat borderWidth;      //default 1
@property (nonatomic, assign) BOOL enable;              //default NO
@property (nonatomic, assign) BOOL opened;              //default NO
+ (instancetype)defaultConfig;

@end

