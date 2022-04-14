//
//  Chart.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.  Copyright © 2019 000. All rights reserved.
//

#import "ZooChart.h"

@implementation ZooChart

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.vauleFormatter = [[NSNumberFormatter alloc] init];
        self.vauleFormatter.maximumFractionDigits = 2;
        self.contentInset = UIEdgeInsetsMake(20, 30, 20, 20);
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 20, 30)];
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)display {}


@end
