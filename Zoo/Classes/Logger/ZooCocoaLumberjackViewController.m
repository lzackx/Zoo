//
//  ZooCocoaLumberjackViewController.m
//  DoraemonKit
//
//  Created by yixiang on 2018/12/4.
//

#import "ZooCocoaLumberjackViewController.h"
#import "ZooCellSwitch.h"
#import "ZooCellButton.h"
#import "DoraemonDefine.h"
#import "ZooCacheManager.h"
#import "ZooCocoaLumberjackListViewController.h"
#import "ZooCocoaLumberjackLogger.h"

@interface ZooCocoaLumberjackViewController ()<DoraemonSwitchViewDelegate,DoraemonCellButtonDelegate>

@property (nonatomic, strong) ZooCellSwitch *switchView;
@property (nonatomic, strong) ZooCellButton *cellBtn;

@end

@implementation ZooCocoaLumberjackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"CocoaLumberjack";
    
    _switchView = [[ZooCellSwitch alloc] initWithFrame:CGRectMake(0, self.bigTitleView.doraemon_bottom, self.view.doraemon_width, kDoraemonSizeFrom750_Landscape(104))];
    [_switchView renderUIWithTitle:DoraemonLocalizedString(@"开关") switchOn:[[ZooCacheManager sharedInstance] loggerSwitch]];
    [_switchView needTopLine];
    [_switchView needDownLine];
    _switchView.delegate = self;
    [self.view addSubview:_switchView];
    
    _cellBtn = [[ZooCellButton alloc] initWithFrame:CGRectMake(0, _switchView.doraemon_bottom, self.view.doraemon_width, kDoraemonSizeFrom750_Landscape(104))];
    [_cellBtn renderUIWithTitle:DoraemonLocalizedString(@"查看记录")];
    _cellBtn.delegate = self;
    [_cellBtn needDownLine];
    [self.view addSubview:_cellBtn];
}

- (BOOL)needBigTitleView{
    return YES;
}

#pragma mark -- DoraemonSwitchViewDelegate
- (void)changeSwitchOn:(BOOL)on sender:(id)sender{
    [[ZooCacheManager sharedInstance] saveLoggerSwitch:on];
    if (on) {
        [[ZooCocoaLumberjackLogger sharedInstance] startMonitor];
    }else{
        [[ZooCocoaLumberjackLogger sharedInstance] stopMonitor];
    }
}

#pragma mark -- DoraemonCellButtonDelegate
- (void)cellBtnClick:(id)sender{
    if (sender == _cellBtn) {
        ZooCocoaLumberjackListViewController *vc = [[ZooCocoaLumberjackListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
