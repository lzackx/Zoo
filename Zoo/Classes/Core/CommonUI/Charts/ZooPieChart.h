//
//  ZooPieChart.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//  Copyright © 2019 000. All rights reserved.
//

#import "ZooChart.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZooPieChart : ZooChart
@property (nonatomic, strong) UIFont *itemDescriptionFont;
@property (nonatomic, strong) UIColor *itemDescriptionTextColor;

@property (nonatomic, assign) CGFloat innerCircleRadiusRatio;

@end

NS_ASSUME_NONNULL_END
