//
//  ZooChartAxis.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.  Copyright © 2019 000. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooChartAxis : NSObject
@property (nonatomic, strong) UIFont *labelFont;
@property (nonatomic, strong) UIColor *labelTextColor;
@property (nonatomic, strong) UIColor *axisLineColor;

@property (nonatomic, assign) CGFloat axisLineWidth;

@property (nonatomic, strong) UIFont *axisLabelFont;
@property (nonatomic, strong) UIColor *axisLabelTextColor;

@property (nonatomic, strong) NSNumberFormatter *vauleFormatter;
@end

NS_ASSUME_NONNULL_END
