//
//  ZooHomeHeadCell.m
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import "ZooHomeHeadCell.h"
#import "ZooDefine.h"

@interface ZooHomeHeadCell()

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end

@implementation ZooHomeHeadCell

- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
    }
    
    return _title;
}

- (UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel new];
    }
    
    return _subTitleLabel;
}

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

- (void)renderUIWithTitle:(NSString *)title{
    _title.text = title;
    _title.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(24)];
    if (_subTitleLabel) {
        [_subTitleLabel removeFromSuperview];
        _subTitleLabel = nil;
    }
    if (title && [title isEqualToString:ZooLocalizedString(@"平台工具")]) {
        [self renderUIWithSubTitle:@"(www.zoo.cn)"];
    }
    [self setNeedsLayout];
}

- (void)renderUIWithSubTitle:(NSString *)subTitle{
    if (subTitle && subTitle.length>0) {
        [self addSubview:self.subTitleLabel];
        self.subTitleLabel.textColor = [UIColor redColor];
        self.subTitleLabel.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(24)];
        self.subTitleLabel.text = subTitle;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.title sizeToFit];
    self.title.frame = CGRectMake(kZooSizeFrom750_Landscape(32), self.zoo_height/2-self.title.zoo_height/2, self.title.zoo_width, self.title.zoo_height);
    if (self.subTitleLabel) {
        [self.subTitleLabel sizeToFit];
        self.subTitleLabel.frame = CGRectMake(self.title.zoo_right+kZooSizeFrom750_Landscape(2), self.zoo_height/2-self.subTitleLabel.zoo_height/2, self.subTitleLabel.zoo_width, self.subTitleLabel.zoo_height);
    }
}

@end
