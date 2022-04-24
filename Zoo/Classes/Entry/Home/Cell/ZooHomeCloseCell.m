//
//  ZooHomeCloseCell.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooHomeCloseCell.h"
#import "ZooManager.h"
#import "ZooHomeWindow.h"
#import "ZooDefine.h"
#import "UIViewController+Zoo.h"

@interface ZooHomeCloseCell ()

@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation ZooHomeCloseCell

- (void)closeButtonHandle{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:ZooLocalizedString(@"提示") message:ZooLocalizedString(@"Zoo关闭之后需要重启App才能重新打开") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:ZooLocalizedString(@"取消") style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:ZooLocalizedString(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[ZooManager shareInstance] hiddenZoo];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [[UIViewController rootViewControllerForKeyWindow] presentViewController:alertController animated:YES completion:nil];

    [[ZooHomeWindow shareInstance] hide];
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
        if (@available(iOS 13.0, *)) {
            UIColor *dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
                    return [UIColor whiteColor];
                } else {
                    return [UIColor zoo_colorWithString:@"#C1C3BF"];
                }
            }];
            _closeButton.backgroundColor = dyColor;
        } else {
#endif
            _closeButton.backgroundColor = [UIColor whiteColor];
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
        }
#endif
        _closeButton.layer.cornerRadius = kZooSizeFrom750_Landscape(5.0);
        _closeButton.layer.masksToBounds = YES;
        [_closeButton setTitle:ZooLocalizedString(@"关闭Zoo") forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor zoo_colorWithString:@"#CC3A4B"] forState:UIControlStateNormal];
        _closeButton.titleLabel.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(28)];
        [_closeButton addTarget:self action:@selector(closeButtonHandle) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeButton;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.closeButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x = kZooSizeFrom750_Landscape(10);

    self.closeButton.frame = CGRectMake(x, 0, self.zoo_width - x * 2, kZooSizeFrom750_Landscape(100));
}

@end
