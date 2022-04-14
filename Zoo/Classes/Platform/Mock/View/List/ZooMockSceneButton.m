//
//  ZooMockDetailButton.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooMockSceneButton.h"
#import "ZooDefine.h"

@interface ZooMockSceneButton()

@property (nonatomic, assign) CGFloat imgSize;
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UILabel *title;


@end

@implementation ZooMockSceneButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _imgSize = kZooSizeFrom750_Landscape(32);
        _img = [[UIImageView alloc] init];
        [self addSubview:_img];
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(28)];
        [self addSubview:_title];
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void) renderTitle:(NSString *)title isSelected:(BOOL)select{
    _img.image = [UIImage zoo_xcassetImageNamed:@"zoo_mock_cancle"];
    _img.frame = CGRectMake(0, 0, _imgSize, _imgSize);
    
    _title.text = title;
    _isSelected = select;
    [_title sizeToFit];
    _title.frame = CGRectMake(_img.zoo_right + kZooSizeFrom750_Landscape(8), 0,  _title.zoo_width, _title.zoo_height);
    if(select){
        [self didSelected];
    }else{
        [self cancelSelected];
    }
}

- (void) didSelected{
    _isSelected = YES;
    _img.image = [UIImage zoo_xcassetImageNamed:@"zoo_mock_selected"];
    _title.textColor = [UIColor zoo_blue];
}

- (void) cancelSelected{
    _isSelected = NO;
    _img.image = [UIImage zoo_xcassetImageNamed:@"zoo_mock_cancle"];
    _title.textColor = [UIColor zoo_black_1];
}

- (void)tap{
    if(_isSelected){
        [self cancelSelected];
    }else{
        [self didSelected];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(sceneBtnClick:)]) {
        [_delegate sceneBtnClick:self.tag];
    }
}

+ (CGFloat)viewWidth:(NSString *)sceneName{
    CGSize fontSize = [sceneName sizeWithAttributes:@{
        @"NSFontAttributeName" : [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(28)]
    }];
    return kZooSizeFrom750_Landscape(32) + kZooSizeFrom750_Landscape(8) + fontSize.width;
}

@end
