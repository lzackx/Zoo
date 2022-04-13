//
//  ZooManagerHeadCell.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooManagerHeadCell.h"
#import "ZooDefine.h"

@interface ZooManagerHeadCell()

@property (nonatomic, strong) UILabel *title;

@end

@implementation ZooManagerHeadCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
        if (@available(iOS 13.0, *)) {
            self.backgroundColor = [UIColor systemBackgroundColor];
        } else {
#endif
            self.backgroundColor = [UIColor whiteColor];
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
        }
#endif
        [self addSubview:self.title];
    }
    return self;
}

- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
        _title.textColor = [UIColor zoo_colorWithString:@"#333333"];
        _title.font = [UIFont boldSystemFontOfSize:kZooSizeFrom750_Landscape(32)];
    }
    
    return _title;
}

- (void)renderUIWithTitle:(NSString *)title{
    _title.text = title;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.title sizeToFit];
    self.title.frame = CGRectMake(kZooSizeFrom750_Landscape(32), self.zoo_height/2-self.title.zoo_height/2, self.title.zoo_width, self.title.zoo_height);
}


@end
