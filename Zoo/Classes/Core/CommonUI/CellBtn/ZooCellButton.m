//
//  ZooCellButton.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooCellButton.h"
#import "ZooDefine.h"

@interface ZooCellButton()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *downLine;
@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation ZooCellButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor zoo_black_1];
        _titleLabel.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(32)];
        [self addSubview:_titleLabel];
        
        _topLine = [[UIView alloc] init];
        _topLine.hidden = YES;
        _topLine.backgroundColor = [UIColor zoo_line];
        [self addSubview:_topLine];
        
        _downLine = [[UIView alloc] init];
        _downLine.hidden = YES;
        _downLine.backgroundColor = [UIColor zoo_line];
        [self addSubview:_downLine];
        
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage zoo_xcassetImageNamed:@"zoo_more"]];
        _arrowImageView.frame = CGRectMake(self.zoo_width-kZooSizeFrom750_Landscape(32)-_arrowImageView.zoo_width, self.zoo_height/2-_arrowImageView.zoo_height/2, _arrowImageView.zoo_width, _arrowImageView.zoo_height);
        [self addSubview:_arrowImageView];
        
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.hidden = YES;
        _rightLabel.textColor = [UIColor zoo_black_2];
        _rightLabel.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(32)];
        [self addSubview:_rightLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)renderUIWithTitle:(NSString *)title{
    _titleLabel.text = title;
    [_titleLabel sizeToFit];
    _titleLabel.frame = CGRectMake(20, self.zoo_height/2-_titleLabel.zoo_height/2, _titleLabel.zoo_width, _titleLabel.zoo_height);
}

- (void)renderUIWithRightContent:(NSString *)rightContent{
    _rightLabel.hidden = NO;
    _rightLabel.text = rightContent;
    [_rightLabel sizeToFit];
    _rightLabel.frame = CGRectMake(_arrowImageView.zoo_left-kZooSizeFrom750_Landscape(24)-_rightLabel.zoo_width, self.zoo_height/2-_rightLabel.zoo_height/2, _rightLabel.zoo_width, _rightLabel.zoo_height);
}

- (void)needTopLine{
    _topLine.hidden = NO;
    _topLine.frame = CGRectMake(0, 0, self.zoo_width, 0.5);
}

- (void)needDownLine{
    _downLine.hidden = NO;
    _downLine.frame = CGRectMake(0, self.zoo_height-0.5, self.zoo_width, 0.5);
}

- (void)tap{
    if (_delegate && [_delegate respondsToSelector:@selector(cellBtnClick:)]) {
        [_delegate cellBtnClick:self];
    }
}

@end
