//
//  ZooChartDataItem.m
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//  Copyright © 2019 000. All rights reserved.
//

#import "ZooChartDataItem.h"

@implementation ZooChartDataItem

- (instancetype)initWithValue:(double)value
                         name:(NSString *)name
                        color:(UIColor *)color {
    if (self = [super init]) {
        self.value = value;
        self.name = name;
        self.color = color;
    }
    return self;
}

@end
