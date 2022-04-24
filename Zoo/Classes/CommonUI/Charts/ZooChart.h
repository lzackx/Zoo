//
//  Chart.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.  Copyright © 2019 000. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZooChartDataItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZooChart : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSNumberFormatter *vauleFormatter;
@property (nonatomic, copy) NSArray<ZooChartDataItem *> *items;
@property (nonatomic, assign) UIEdgeInsets contentInset;

- (void)display;
@end

NS_ASSUME_NONNULL_END
