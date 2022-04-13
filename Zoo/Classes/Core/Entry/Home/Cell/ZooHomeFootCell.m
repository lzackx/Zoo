//
//  ZooHomeFootCell.m
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import "ZooHomeFootCell.h"

@implementation ZooHomeFootCell

- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
    }
    
    return _title;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.title];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.title.frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(0, 15, 0, 15));
}

@end
