//
//  ZooBaseViewController.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.  
//

#import "ZooBaseViewController.h"
#import "ZooNavBarItemModel.h"
#import "UIImage+Zoo.h"
#import "ZooHomeWindow.h"
#import "UIView+Zoo.h"
#import "ZooDefine.h"

@interface ZooBaseViewController ()<ZooBaseBigTitleViewDelegate>
 
@property (nonatomic, strong) ZooNavBarItemModel *leftModel;

@property (nonatomic, strong) NSArray *leftNavBarItemArray;
@end

@implementation ZooBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor systemBackgroundColor];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor labelColor]}];
        if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            [self.navigationController.navigationBar setShadowImage:[UIImage zoo_imageWithColor:[UIColor zoo_black_3] size:CGSizeMake(self.view.frame.size.width, 0.5)]];
        }
    } else {
#endif
        self.view.backgroundColor = [UIColor whiteColor];
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
    }
#endif
     
    if ([self needBigTitleView]) {
        _bigTitleView = [[ZooBaseBigTitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.zoo_width, kZooSizeFrom750_Landscape(178))];
        _bigTitleView.delegate = self;
        [self.view addSubview:_bigTitleView];
    } else {
        UIImage *image = [UIImage zoo_xcassetImageNamed:@"zoo_back"];
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
        if (@available(iOS 13.0, *)) {
            if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                image = [UIImage zoo_xcassetImageNamed:@"zoo_back_dark"];
            }
        }
#endif
        self.leftModel = [[ZooNavBarItemModel alloc] initWithImage:image selector:@selector(leftNavBackClick:)];
        [self setLeftNavBarItems:@[self.leftModel]];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = [self needBigTitleView];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //输入框聚焦的时候，会把当前window设置为keyWindow，我们在当页面消失的时候，判断一下，把keyWindow交还给[[UIApplication sharedApplication].delegate window]
    if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
        UIWindow *appWindow = [[UIApplication sharedApplication].delegate window];
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        if (appWindow != keyWindow) {
            [appWindow makeKeyWindow];
        }
    }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    // trait发生了改变
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
    if (@available(iOS 13.0, *)) {
        if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
            if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                self.leftModel.image = [UIImage zoo_xcassetImageNamed:@"zoo_back_dark"];
                [self.navigationController.navigationBar setShadowImage:[UIImage zoo_imageWithColor:[UIColor zoo_black_3] size:CGSizeMake(self.view.frame.size.width, 0.5)]];
            } else {
                self.leftModel.image = [UIImage zoo_xcassetImageNamed:@"zoo_back"];
            }
            if (self.leftNavBarItemArray) {
                [self setLeftNavBarItems:self.leftNavBarItemArray];
            }
        }
    }
#endif
}

//是否需要大标题，默认不需要
- (BOOL)needBigTitleView{
    return NO;
}

- (void)setTitle:(NSString *)title{
    if (_bigTitleView && !_bigTitleView.hidden) {
        [_bigTitleView setTitle:title];
    }else{
        [super setTitle:title];
    }
}

- (void)leftNavBackClick:(id)clickView{
    if (self.navigationController.viewControllers.count==1) {
        [[ZooHomeWindow shareInstance] hide];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)setLeftNavBarItems:(NSArray *)items{
    _leftNavBarItemArray = items;
    NSArray *barItems = [self navigationItems:items];
    if (barItems) {
        self.navigationItem.leftBarButtonItems = barItems;
    }
}

- (void)setRightNavBarItems:(NSArray *)items{
    NSArray *barItems = [self navigationItems:items];
    if (barItems) {
        self.navigationItem.rightBarButtonItems = barItems;
    }
}

- (void)setRightNavTitle:(NSString *)title{
    ZooNavBarItemModel *item = [[ZooNavBarItemModel alloc] initWithText:title color:[UIColor zoo_blue] selector:@selector(rightNavTitleClick:)];
    NSArray *barItems = [self navigationItems:@[item]];
    if (barItems) {
        self.navigationItem.rightBarButtonItems = barItems;
    }
}


- (NSArray *)navigationItems:(NSArray *)items{
    NSMutableArray *barItems = [NSMutableArray array];
    //距离左右的间距
    UIBarButtonItem *spacer = [self getSpacerByWidth:-10];
    [barItems addObject:spacer];
    
    for (NSInteger i=0; i<items.count; i++) {
        
        ZooNavBarItemModel *model = items[i];
        UIBarButtonItem *barItem;
        if (model.type == ZooNavBarItemTypeText) {//文字按钮
            barItem = [[UIBarButtonItem alloc] initWithTitle:model.text style:UIBarButtonItemStylePlain target:self action:model.selector];
            barItem.tintColor = model.textColor;
        }else if(model.type == ZooNavBarItemTypeImage){//图片按钮
            UIImage *image = [model.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//设置图片没有默认蓝色效果
            //默认的间距太大
//            barItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:model.selector];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:image forState:UIControlStateNormal];
            [btn addTarget:self action:model.selector forControlEvents:UIControlEventTouchUpInside];
            btn.frame = CGRectMake(0, 0, 30, 30);
            btn.clipsToBounds = YES;
            barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        }else{
            barItem = [[UIBarButtonItem alloc] init];
        }
        [barItems addObject:barItem];
    }
    return barItems;
}

/**
 * 获取间距
 */
- (UIBarButtonItem *)getSpacerByWidth : (CGFloat)width{
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                               target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    spacer.width = width;
    return spacer;
}

#pragma mark - ZooBaseBigTitleViewDelegate
- (void)bigTitleCloseClick{
    [self leftNavBackClick:nil];
}

- (void)rightNavTitleClick:(id)clickView{
    
}

//点击屏幕空白处收起键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
