//
//  ZooYAxis.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//  Copyright © 2019 000. All rights reserved.
//

#import "ZooChartAxis.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZooYAxis : ZooChartAxis
@property (nonatomic, assign) CGFloat marginTop;
@property (nonatomic, assign) CGFloat labelWidth;
@property (nonatomic, assign) NSInteger labelCount;
@property (nonatomic, assign) double maxY;
@property (nonatomic, copy) NSArray<NSString *> *labels;
@property (nonatomic, copy) NSArray<NSNumber *> *values;
- (void)update;
@end

NS_ASSUME_NONNULL_END
