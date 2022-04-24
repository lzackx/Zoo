//
//  ZooHomeCell.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooHomeCell.h"
#import "ZooDefine.h"

@interface ZooHomeCell()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;

@end

@implementation ZooHomeCell

- (UIImageView *)icon {
    if (!_icon) {
        CGFloat size = kZooSizeFrom750_Landscape(68);
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake((self.zoo_width - size) / 2.0, 4, size, size)];
    }
    
    return _icon;
}

- (UILabel *)name {
    if (!_name) {
        CGFloat height = kZooSizeFrom750_Landscape(32);
        _name = [[UILabel alloc] initWithFrame:CGRectMake(0, self.zoo_height - height - 4, self.zoo_width, height)];
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
        [self addSubview:self.icon];
        [self addSubview:self.name];
    }
    return self;
}

- (void)update:(NSString *)image name:(NSString *)name {
    self.icon.image = [UIImage zoo_xcassetImageNamed:image];
    self.name.text = name;
}

- (void)updateImage:(UIImage *)image {
    if (image) {
        self.icon.image = image;
    }
}

@end
