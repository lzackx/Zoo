//
//  ZooMethodUseTimeViewController.m
//  DoraemonKit
//
//  Created by yixiang on 2019/1/18.
//

#import "ZooMethodUseTimeViewController.h"
#import "ZooCellSwitch.h"
#import "UIView+Doraemon.h"
#import "ZooCellButton.h"
#import "Zooi18NUtil.h"
#import "ZooMethodUseTimeManager.h"
#import "ZooMethodUseTimeListViewController.h"
#import "DoraemonDefine.h"

@interface ZooMethodUseTimeViewController ()<DoraemonSwitchViewDelegate,DoraemonCellButtonDelegate>

@property (nonatomic, strong) ZooCellSwitch *switchView;
@property (nonatomic, strong) ZooCellButton *cellBtn;

@end

@implementation ZooMethodUseTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = DoraemonLocalizedString(@"Load耗时");
    
    _switchView = [[ZooCellSwitch alloc] initWithFrame:CGRectMake(0, self.bigTitleView.doraemon_bottom, self.view.doraemon_width, 53)];
    [_switchView renderUIWithTitle:DoraemonLocalizedString(@"Load耗时检测开关") switchOn:[ZooMethodUseTimeManager sharedInstance].on];
    [_switchView needTopLine];
    [_switchView needDownLine];
    _switchView.delegate = self;
    [self.view addSubview:_switchView];
    
    _cellBtn = [[ZooCellButton alloc] initWithFrame:CGRectMake(0, _switchView.doraemon_bottom, self.view.doraemon_width, 53)];
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
    __weak typeof(self) weakSelf = self;
    [ZooAlertUtil handleAlertActionWithVC:self okBlock:^{
        [ZooMethodUseTimeManager sharedInstance].on = on;
        exit(0);
    } cancleBlock:^{
        weakSelf.switchView.switchView.on = !on;
    }];
}

#pragma mark -- DoraemonCellButtonDelegate
- (void)cellBtnClick:(id)sender{
    if (sender == _cellBtn) {
        ZooMethodUseTimeListViewController *vc = [[ZooMethodUseTimeListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
