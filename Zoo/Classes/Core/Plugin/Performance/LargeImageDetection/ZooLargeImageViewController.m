//
//  ZooLargeImageViewController.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooLargeImageViewController.h"
#import "ZooCellSwitch.h"
#import "ZooCellButton.h"
#import "ZooCacheManager.h"
#import "ZooNetworkInterceptor.h"
#import "ZooLargeImageDetectionManager.h"
#import "ZooLargeImageDetectionListViewController.h"
#import "ZooCellInput.h"
#import "ZooDefine.h"

@interface ZooLargeImageViewController() <ZooSwitchViewDelegate, ZooCellButtonDelegate>

@property (nonatomic, strong) ZooCellSwitch *switchView;
@property (nonatomic, strong) ZooCellButton *cellBtn;
@end

@implementation ZooLargeImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    self.title = ZooLocalizedString(@"大图检测");
    
    _switchView = [[ZooCellSwitch alloc] initWithFrame:CGRectMake(0, self.bigTitleView.zoo_bottom, self.view.zoo_width, kZooSizeFrom750(104))];
    [_switchView renderUIWithTitle:ZooLocalizedString(@"大图检测开关") switchOn:[[ZooLargeImageDetectionManager shareInstance] detecting]];
    [_switchView needTopLine];
    [_switchView needDownLine];
    _switchView.delegate = self;
    [self.view addSubview:_switchView];
    
    _cellBtn = [[ZooCellButton alloc] initWithFrame:CGRectMake(0, _switchView.zoo_bottom, self.view.zoo_width, kZooSizeFrom750(104))];
    [_cellBtn renderUIWithTitle:ZooLocalizedString(@"查看检测记录")];
    _cellBtn.delegate = self;
    [_cellBtn needDownLine];
    [self.view addSubview:_cellBtn];
}

- (BOOL)needBigTitleView{
    return YES;
}

- (void)changeSwitchOn:(BOOL)on sender:(id)sender {
    [ZooLargeImageDetectionManager shareInstance].detecting = on;
}

- (void)cellBtnClick:(id)sender {
    ZooLargeImageDetectionListViewController *vc = [[ZooLargeImageDetectionListViewController alloc] initWithImages: [ZooLargeImageDetectionManager shareInstance].images];
    [self.navigationController pushViewController:vc animated:YES];
}
@end