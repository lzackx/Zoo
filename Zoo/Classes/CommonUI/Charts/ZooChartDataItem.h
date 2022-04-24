//
//  ZooChartDataItem.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.  Copyright © 2019 000. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooChartDataItem : NSObject
@property (nonatomic, assign) double value;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIColor *color;


- (instancetype)initWithValue:(double)value
                         name:(NSString *)name
                        color:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
