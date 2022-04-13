//
//  ZooMockUploadDataViewController.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooMockUploadViewController.h"
#import "ZooDefine.h"
#import "ZooMockUploadListView.h"
#import "ZooMockDataPreviewViewController.h"

@interface ZooMockUploadViewController ()<ZooMockUploadListViewDelegate>

@property (nonatomic, strong) ZooMockUploadListView *detailView;


@end

@implementation ZooMockUploadViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = ZooLocalizedString(@"上传模版");
    
    self.searchView.textField.text = [ZooMockManager sharedInstance].uploadSearchText;
    
    _detailView = [[ZooMockUploadListView alloc] initWithFrame:CGRectMake(0, self.sepeatorLine.zoo_bottom, self.view.zoo_width, self.view.zoo_height - self.sepeatorLine.zoo_bottom)];
    _detailView.delegate = self;
    [self.view addSubview:_detailView];
    
    NSString *leftTitle = [ZooMockManager sharedInstance].uploadGroup;
    if ([leftTitle isEqualToString:@"所有"]) {
        leftTitle = @"接口分组";
    }
    [self.leftButton renderUIWithTitle:leftTitle];
    
    NSString *rightTitle = [ZooMockManager sharedInstance].uploadState;
    if ([rightTitle isEqualToString:@"所有"]) {
        rightTitle = @"开关状态";
    }
    [self.rightButton renderUIWithTitle:rightTitle];
}

#pragma mark - ZooMockUploadListViewDelegate
- (void)previewClick:(ZooMockUpLoadModel *)uploadModel{
    NSString *result = uploadModel.result;
    if (result && result.length>0) {
        ZooMockDataPreviewViewController *vc = [[ZooMockDataPreviewViewController alloc] init];
        vc.upLoadModel = uploadModel;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [ZooToastUtil showToastBlack:@"数据预览为空" inView:self.view];
    }
}

#pragma mark --ZooMockFilterBgroundDelegate
- (void)filterSelectedClick{
    if(self.rightButton.down){
        NSString *rightTitle = [ZooMockManager sharedInstance].states[self.listView.selectedIndex];
        [ZooMockManager sharedInstance].uploadState = rightTitle;
        if ([rightTitle isEqualToString:@"所有"]) {
            rightTitle = @"开关状态";
        }
        [self.rightButton renderUIWithTitle:rightTitle];
    }else{
        NSString *leftTitle = [ZooMockManager sharedInstance].groups[self.listView.selectedIndex];
        [ZooMockManager sharedInstance].uploadGroup = leftTitle;
        if ([leftTitle isEqualToString:@"所有"]) {
            leftTitle = @"接口分组";
        }
        [self.leftButton renderUIWithTitle:leftTitle];
    }
    
    [super filterSelectedClick];
    
    [_detailView reloadUI];
}

#pragma mark - ZooMockSearchViewDelegate
- (void)searchViewInputChange:(NSString *)text{
    [ZooMockManager sharedInstance].uploadSearchText = text;
    [self.detailView reloadUI];
}

@end
