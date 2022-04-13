//
//  ZooMockHalfButton.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooMockFilterButton.h"
#import "ZooDefine.h"

@interface ZooMockFilterButton()

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIImageView *arrow;

@end

@implementation ZooMockFilterButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor zoo_black_1];
        _titleLabel.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(28)];
        [self addSubview:_titleLabel];
        _down = NO;
        _arrow = [[UIImageView alloc] init];
        [self addSubview:_arrow];
        
        UITapGestureRecognizer *todo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:todo];
        
        _selectedItemIndex = 0;
    }
    return self;
}


- (void)renderUIWithTitle:(NSString *)title{

    _titleLabel.text = ZooLocalizedString(title);
    [_titleLabel sizeToFit];
    _titleLabel.frame = CGRectMake(self.zoo_width/2-_titleLabel.zoo_width/3*2, self.zoo_height/2-_titleLabel.zoo_height/2, _titleLabel.zoo_width, _titleLabel.zoo_height);
    _arrow.image = [UIImage zoo_xcassetImageNamed:@"zoo_mock_filter_down"];
    _arrow.frame = CGRectMake(_titleLabel.zoo_right + _arrow.image.size.width, self.zoo_height/2-_arrow.image.size.height/2, _arrow.image.size.width, _arrow.image.size.height);
}

- (void)setDropdown:(BOOL )isDown{
    NSString *imgName = @"zoo_mock_filter_down";
    _down = NO;
    if(isDown){
        imgName = @"zoo_mock_filter_up";
        _down = YES;
    }
    _arrow.image = [UIImage zoo_xcassetImageNamed:imgName];
    _arrow.zoo_width = _arrow.image.size.width;
    _arrow.zoo_height = _arrow.image.size.height;
}

- (void)tap{
    if (_delegate && [_delegate respondsToSelector:@selector(filterBtnClick:)]) {
        _down = !_down;
        [self setDropdown:self.down];
        [_delegate filterBtnClick:self];
    }
}

@end
