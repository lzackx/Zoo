//
//  ZooCellInput.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooCellInput.h"
#import "ZooDefine.h"

@interface ZooCellInput()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *downLine;

@end

@implementation ZooCellInput

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kZooSizeFrom750_Landscape(32), 0, kZooSizeFrom750_Landscape(150), self.zoo_height)];
        _titleLabel.textColor = [UIColor zoo_black_1];
        _titleLabel.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(32)];
        [self addSubview:_titleLabel];
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(_titleLabel.zoo_right+kZooSizeFrom750_Landscape(30), self.zoo_height/2-kZooSizeFrom750_Landscape(48)/2, self.zoo_width-_titleLabel.zoo_right-kZooSizeFrom750_Landscape(30), kZooSizeFrom750_Landscape(48))];
        [self addSubview:_textField];
        
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

- (void)renderUIWithTitle:(NSString *)title{
    _titleLabel.text = title;
}

- (void)renderUIWithPlaceholder:(NSString *)placeholder{
    _textField.placeholder = placeholder;
}

- (void)needTopLine{
    _topLine.hidden = NO;
    _topLine.frame = CGRectMake(0, 0, self.zoo_width, 0.5);
}

- (void)needDownLine{
    _downLine.hidden = NO;
    _downLine.frame = CGRectMake(0, self.zoo_height-0.5, self.zoo_width, 0.5);
}

@end
