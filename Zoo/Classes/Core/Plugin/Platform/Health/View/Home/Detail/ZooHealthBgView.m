//
//  ZooHealthBgView.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooHealthBgView.h"
#import "ZooDefine.h"

@interface ZooHealthBgView()

@property (nonatomic, strong) UIImageView *bgImgView;

@end

@implementation ZooHealthBgView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat bg_x = kZooSizeFrom750_Landscape(98);
        CGFloat bg_width = self.zoo_width - bg_x * 2;
        _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(bg_x,kZooSizeFrom750_Landscape(89), bg_width, bg_width*16/9)];
        [_bgImgView setImage:[UIImage zoo_xcassetImageNamed:@"zoo_health_bg"]];
        [self addSubview:_bgImgView];
        self.userInteractionEnabled = NO;
        [self sendSubviewToBack:_bgImgView];
    }
    return self;
}

- (CGRect)getStartingTitleCGRect{
    CGRect rect;
    rect.size.width = self.zoo_width; rect.size.height = kZooSizeFrom750_Landscape(40);
    rect.origin.x = 0; rect.origin.y = _bgImgView.zoo_y + _bgImgView.zoo_height* 11/60;//根据图片比例获取
    return rect;
}

- (CGRect)getButtonCGRect{
    CGPoint point = CGPointMake(_bgImgView.zoo_x + _bgImgView.zoo_width/2, _bgImgView.zoo_y + _bgImgView.zoo_height * 7/10);//根据图片比例获取
    CGRect rect;
    rect.size.width = _bgImgView.zoo_width*2/5; rect.size.height = rect.size.width;
    rect.origin.x = point.x - rect.size.width/2 ; rect.origin.y = point.y - rect.size.width/2 + kZooSizeFrom750_Landscape(5);

    return rect;
}

@end
