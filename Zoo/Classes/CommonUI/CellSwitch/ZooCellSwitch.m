//
//  ZooSwitchView.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooCellSwitch.h"
#import "ZooDefine.h"

@interface ZooCellSwitch()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *downLine;

@end

@implementation ZooCellSwitch

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor zoo_black_1];
        _titleLabel.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(32)];
        [self addSubview:_titleLabel];
        
        _switchView = [[UISwitch alloc] init];
        _switchView.onTintColor = [UIColor zoo_blue];
        [_switchView addTarget:self action:@selector(switchChange:)forControlEvents:UIControlEventValueChanged];
        [self addSubview:_switchView];
        
        _topLine = [[UIView alloc] init];
        _topLine.hidden = YES;
        _topLine.backgroundColor = [UIColor zoo_line];
        [self addSubview:_topLine];
        
        _downLine = [[UIView alloc] init];
        _downLine.hidden = YES;
        _downLine.backgroundColor = [UIColor zoo_line];
        [self addSubview:_downLine];
    }
    return self;
}

- (void)renderUIWithTitle:(NSString *)title switchOn:(BOOL)on{
    _titleLabel.text = title;
    [_titleLabel sizeToFit];
    _titleLabel.frame = CGRectMake(20, self.zoo_height/2-_titleLabel.zoo_height/2, _titleLabel.zoo_width, _titleLabel.zoo_height);
    
    _switchView.on = on;
    _switchView.frame = CGRectMake(self.zoo_width-20-_switchView.zoo_width, self.zoo_height/2-_switchView.zoo_height/2, _switchView.zoo_width, _switchView.zoo_height);
}

- (void)needTopLine{
    _topLine.hidden = NO;
    _topLine.frame = CGRectMake(0, 0, self.zoo_width, 0.5);
}

- (void)needDownLine{
    _downLine.hidden = NO;
    _downLine.frame = CGRectMake(0, self.zoo_height-0.5, self.zoo_width, 0.5);
}

- (void)switchChange:(UISwitch*)sender{
    BOOL on = sender.on;
    if (_delegate && [_delegate respondsToSelector:@selector(changeSwitchOn:sender:)]) {
        [_delegate changeSwitchOn:on sender:sender];
    }
}


@end
