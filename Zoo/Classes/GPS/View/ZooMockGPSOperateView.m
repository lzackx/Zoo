//
//  ZooMockGPSOperateView.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooMockGPSOperateView.h"
#import "ZooDefine.h"

@interface ZooMockGPSOperateView()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZooMockGPSOperateView

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
        self.layer.cornerRadius = kZooSizeFrom750_Landscape(8);
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(32)];
        _titleLabel.textColor = [UIColor zoo_black_1];
        _titleLabel.text = ZooLocalizedString(@"打开Mock GPS");
        [self addSubview:_titleLabel];
        [_titleLabel sizeToFit];
        _titleLabel.frame = CGRectMake(kZooSizeFrom750_Landscape(32), self.zoo_height/2-_titleLabel.zoo_height/2, _titleLabel.zoo_width, _titleLabel.zoo_height);
        
        _switchView = [[UISwitch alloc] init];
        _switchView.onTintColor = [UIColor zoo_blue];
        _switchView.zoo_origin = CGPointMake(self.zoo_width-kZooSizeFrom750_Landscape(32)-_switchView.zoo_width, self.zoo_height/2-_switchView.zoo_height/2);
        [self addSubview:_switchView];
    }
    return self;
}

@end
