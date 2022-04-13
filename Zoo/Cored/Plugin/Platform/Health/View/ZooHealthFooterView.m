//
//  ZooHealthFooterView.m
//  ZooKit
//
//  Created by lZackx on 04/12/2022 
//

#import "ZooHealthFooterView.h"
#import "ZooDefine.h"

@interface ZooHealthFooterView ()

@property (nonatomic, strong) UILabel *footerTitle;
@property (nonatomic, strong) UIImageView *footerImg;
@property (nonatomic, strong) NSDictionary *titleDictionary;

@end

@implementation ZooHealthFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _footerTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.zoo_width, kZooSizeFrom750_Landscape(36))];
        _footerTitle.textAlignment = NSTextAlignmentCenter;
        _footerTitle.textColor = [UIColor zoo_colorWithString:@"#27BCB7"];
        [_footerTitle setFont:[UIFont systemFontOfSize:kZooSizeFrom750_Landscape(24)]];
        CGFloat size = kZooSizeFrom750_Landscape(56);
        _footerImg = [[UIImageView alloc] initWithFrame:CGRectMake((self.zoo_width - size)/2, size, size, size)];
        _footerImg.userInteractionEnabled = YES;
        
        [self addSubview:_footerTitle];
        [self addSubview:_footerImg];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [_footerImg addGestureRecognizer:tap];
    }
    return self;
}

- (void)renderUIWithTitleImg:(NSString *)title img:(NSString *)imgName{
    [_footerTitle setText:title];
    [_footerImg setImage:[UIImage zoo_xcassetImageNamed:imgName]];
}

- (void)renderUIWithTitleImg:(BOOL)top{
    NSString *title;
    NSString *icon;
    _top = top;
    if(top){
        title = self.titleDictionary[@"top"];
        icon = self.titleDictionary[@"top_icon"];
    }else{
        title = self.titleDictionary[@"bottom"];
        icon = self.titleDictionary[@"bottom_icon"];
    }
    [_footerTitle setText:ZooLocalizedString(title)];
    [_footerImg setImage:[UIImage zoo_xcassetImageNamed:icon]];
}

- (NSDictionary *)titleDictionary{
    if(!_titleDictionary){
        _titleDictionary =  @{
            @"top":@"向下滑动查看功能使用说明",
            @"bottom":@"回到顶部",
            @"top_icon":@"zoo_health_slide",
            @"bottom_icon":@"zoo_health_slideTop",
        };
    }
    return _titleDictionary;
}

- (void)tap{
    if (_delegate && [_delegate respondsToSelector:@selector(footerBtnClick:)]) {
        [_delegate footerBtnClick:self];
    }
}


@end
