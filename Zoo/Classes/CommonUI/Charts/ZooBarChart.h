//
//  BarChart.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.  Copyright © 2019 000. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZooChart.h"
#import "ZooXAxis.h"
#import "ZooYAxis.h"
#import "ZooChartDataItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZooBarChart : ZooChart
@property (nonatomic, strong) ZooXAxis *xAxis;
@property (nonatomic, strong) ZooYAxis *yAxis;
@property (nonatomic, assign) CGFloat barsSpacingRatio;

@end

NS_ASSUME_NONNULL_END
