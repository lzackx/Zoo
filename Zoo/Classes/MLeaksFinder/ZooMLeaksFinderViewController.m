//
//  ZooMLeaksFinderViewController.m
//  DoraemonKit
//
//  Created by didi on 2019/10/6.
//

#import "ZooMLeaksFinderViewController.h"
#import "ZooCellSwitch.h"
#import "ZooCellButton.h"
#import "DoraemonDefine.h"
#import "ZooCacheManager.h"
#import "ZooMLeaksFinderListViewController.h"


@interface ZooMLeaksFinderViewController ()<DoraemonSwitchViewDelegate,DoraemonCellButtonDelegate>

@property (nonatomic, strong) ZooCellSwitch *switchView;
@property (nonatomic, strong) ZooCellSwitch *alertSwitchView;
@property (nonatomic, strong) ZooCellButton *cellBtn;

@end

@implementation ZooMLeaksFinderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = DoraemonLocalizedString(@"内存泄漏");
    
    _switchView = [[ZooCellSwitch alloc] initWithFrame:CGRectMake(0, self.bigTitleView.doraemon_bottom, self.view.doraemon_width, 53)];
    [_switchView renderUIWithTitle:DoraemonLocalizedString(@"内存泄漏检测开关") switchOn:[[ZooCacheManager sharedInstance] memoryLeak]];
    [_switchView needTopLine];
    [_switchView needDownLine];
    _switchView.delegate = self;
    [self.view addSubview:_switchView];
    
    _alertSwitchView = [[ZooCellSwitch alloc] initWithFrame:CGRectMake(0, _switchView.doraemon_bottom, self.view.doraemon_width, 53)];
    [_alertSwitchView renderUIWithTitle:DoraemonLocalizedString(@"内存泄漏检测弹框提醒") switchOn:[[ZooCacheManager sharedInstance] memoryLeakAlert]];
    [_alertSwitchView needDownLine];
    _alertSwitchView.delegate = self;
    [self.view addSubview:_alertSwitchView];
    
    _cellBtn = [[ZooCellButton alloc] initWithFrame:CGRectMake(0, _alertSwitchView.doraemon_bottom, self.view.doraemon_width, 53)];
    [_cellBtn renderUIWithTitle:DoraemonLocalizedString(@"查看检测记录")];
    _cellBtn.delegate = self;
    [_cellBtn needDownLine];
    [self.view addSubview:_cellBtn];
}

- (BOOL)needBigTitleView{
    return YES;
}

#pragma mark -- DoraemonSwitchViewDelegate
- (void)changeSwitchOn:(BOOL)on sender:(id)sender{
    if (sender == _switchView.switchView) {
        __weak typeof(self) weakSelf = self;
        [ZooAlertUtil handleAlertActionWithVC:self okBlock:^{
            [[ZooCacheManager sharedInstance] saveMemoryLeak:on];
            exit(0);
        } cancleBlock:^{
            weakSelf.switchView.switchView.on = !on;
        }];
    }else{
        [[ZooCacheManager sharedInstance] saveMemoryLeakAlert:on];
    }
}

#pragma mark -- DoraemonCellButtonDelegate
- (void)cellBtnClick:(id)sender{
    if (sender == _cellBtn) {
        ZooMLeaksFinderListViewController *vc = [[ZooMLeaksFinderListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
