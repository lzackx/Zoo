//
//  ZooChartAxis.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.  Copyright © 2019 000. All rights reserved.
//

#import "ZooChartAxis.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation ZooChartAxis

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.labelFont = [UIFont systemFontOfSize:13];
        self.axisLineColor = [UIColor grayColor];
        self.axisLineWidth = 1;
        self.axisLabelFont = [UIFont systemFontOfSize:13];
        self.axisLabelTextColor = [UIColor grayColor];
        self.vauleFormatter = [[NSNumberFormatter alloc] init];
    }
    return self;
}

- (NSNumberFormatter *)vauleFormatter {
    if (!_vauleFormatter) {
        _vauleFormatter = [[NSNumberFormatter alloc] init];
        _vauleFormatter.maximumFractionDigits = 2;
    }
    return _vauleFormatter;
}

@end
