//
//  ZooHealthEndInputView.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooHealthEndInputView.h"
#import "ZooDefine.h"

@implementation ZooHealthEndInputView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat padding = kZooSizeFrom750_Landscape(40);
        _label = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0, self.zoo_width - padding*2, padding + kZooSizeFrom750_Landscape(5))];
        _label.textAlignment = NSTextAlignmentLeft;
        _label.textColor = [UIColor zoo_black_3];
        _label.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(24)];
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(padding, _label.zoo_bottom, self.zoo_width- padding*2, padding*2)];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.font = _label.font;
        _textField.layer.borderColor = [UIColor zoo_black_1].CGColor;
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.layer.cornerRadius = kZooSizeFrom750_Landscape(8);
        
        [self addSubview:_label];
        [self addSubview:_textField];
    }
    return self;
}

- (void)renderUIWithTitle:(NSString *)tip placeholder:(NSString *)placeholder{
    _label.text = tip;
    _textField.placeholder = placeholder;
}

@end
