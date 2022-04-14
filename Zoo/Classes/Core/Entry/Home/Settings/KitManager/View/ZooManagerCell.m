//
//  ZooManagerCell.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooManagerCell.h"
#import "ZooDefine.h"

@interface ZooManagerCell()

@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIImageView *select;
@property (nonatomic, strong) UIView *maskView;

@end

@implementation ZooManagerCell

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
        self.layer.borderWidth = kZooSizeFrom750_Landscape(1);
        self.layer.borderColor = [UIColor zoo_colorWithHexString:@"#EEEEEE"].CGColor;
        
        [self addSubview:self.centerView];
        [self addSubview:self.maskView];
        [self addSubview:self.select];
        
        [self.centerView addSubview:self.icon];
        [self.centerView addSubview:self.name];
        
        CGFloat centerViewH = self.name.zoo_bottom;
        self.centerView.frame = CGRectMake(self.centerView.zoo_left, (self.zoo_height-centerViewH)/2, self.centerView.zoo_width, centerViewH);
    }
    return self;
}

- (UIView *)centerView{
    if (!_centerView) {
        _centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.zoo_width, 0)];
    }
    return _centerView;
}

- (UIImageView *)icon {
    if (!_icon) {
        CGFloat size = kZooSizeFrom750_Landscape(60);
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake((self.centerView.zoo_width - size) / 2.0, 0, size, size)];
    }
    
    return _icon;
}

- (UILabel *)name {
    if (!_name) {
        CGFloat height = kZooSizeFrom750_Landscape(33);
        _name = [[UILabel alloc] initWithFrame:CGRectMake(0, self.icon.zoo_bottom+kZooSizeFrom750_Landscape(16), self.centerView.zoo_width, height)];
        _name.textAlignment = NSTextAlignmentCenter;
        _name.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(24)];
        _name.adjustsFontSizeToFitWidth = YES;
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
        if (@available(iOS 13.0, *)) {
            _name.textColor = [UIColor labelColor];
        }
#endif
    }
    
    return _name;
}

- (UIImageView *)select{
    if (!_select) {
        CGFloat size = kZooSizeFrom750_Landscape(28);
        _select = [[UIImageView alloc] initWithFrame:CGRectMake(self.zoo_width-kZooSizeFrom750_Landscape(12)-size, kZooSizeFrom750_Landscape(12), size, size)];
    }
    return _select;
}

- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:self.bounds];
        _maskView.backgroundColor = [UIColor whiteColor];
        _maskView.alpha = 0.5;
    }
    return _maskView;
}


- (void)update:(NSString *)image name:(NSString *)name select:(BOOL)select editStatus:(BOOL)editStatus{
    self.icon.image = [UIImage zoo_xcassetImageNamed:image];
    self.name.text = name;
    if (editStatus) {
        self.select.hidden = NO;
        if (select) {
            self.select.image = [UIImage zoo_xcassetImageNamed:@"zoo_check_circle_fill"];
            self.maskView.hidden = YES;
        }else{
            self.select.image = [UIImage zoo_xcassetImageNamed:@"zoo_check_circle"];
            self.maskView.hidden = NO;
        }
    }else{
        self.select.hidden = YES;
        self.maskView.hidden = YES;
    }
}

- (void)updateImage:(UIImage *)image {
    if (image) {        
        self.icon.image = image;
    }
}


@end
