//
//  ZooCocoaLumberjackViewController.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooCocoaLumberjackViewController.h"
#import "ZooCellSwitch.h"
#import "ZooCellButton.h"
#import "ZooDefine.h"
#import "ZooCacheManager.h"
#import "ZooCocoaLumberjackListViewController.h"
#import "ZooCocoaLumberjackLogger.h"

@interface ZooCocoaLumberjackViewController ()<ZooSwitchViewDelegate,ZooCellButtonDelegate>

@property (nonatomic, strong) ZooCellSwitch *switchView;
@property (nonatomic, strong) ZooCellButton *cellBtn;

@end

@implementation ZooCocoaLumberjackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"CocoaLumberjack";
    
    _switchView = [[ZooCellSwitch alloc] initWithFrame:CGRectMake(0, self.bigTitleView.zoo_bottom, self.view.zoo_width, kZooSizeFrom750_Landscape(104))];
    [_switchView renderUIWithTitle:ZooLocalizedString(@"开关") switchOn:[[ZooCacheManager sharedInstance] loggerSwitch]];
    [_switchView needTopLine];
    [_switchView needDownLine];
    _switchView.delegate = self;
    [self.view addSubview:_switchView];
    
    _cellBtn = [[ZooCellButton alloc] initWithFrame:CGRectMake(0, _switchView.zoo_bottom, self.view.zoo_width, kZooSizeFrom750_Landscape(104))];
    [_cellBtn renderUIWithTitle:ZooLocalizedString(@"查看记录")];
    _cellBtn.delegate = self;
    [_cellBtn needDownLine];
    [self.view addSubview:_cellBtn];
}

- (BOOL)needBigTitleView{
    return YES;
}

#pragma mark -- ZooSwitchViewDelegate
- (void)changeSwitchOn:(BOOL)on sender:(id)sender{
    [[ZooCacheManager sharedInstance] saveLoggerSwitch:on];
    if (on) {
        [[ZooCocoaLumberjackLogger sharedInstance] startMonitor];
    }else{
        [[ZooCocoaLumberjackLogger sharedInstance] stopMonitor];
    }
}

#pragma mark -- ZooCellButtonDelegate
- (void)cellBtnClick:(id)sender{
    if (sender == _cellBtn) {
        ZooCocoaLumberjackListViewController *vc = [[ZooCocoaLumberjackListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
