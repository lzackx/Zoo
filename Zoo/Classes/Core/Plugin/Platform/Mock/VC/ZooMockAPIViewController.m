//
//  ZooMockDataViewController.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooMockAPIViewController.h"
#import "ZooDefine.h"
#import "ZooMockApiListView.h"


@interface ZooMockAPIViewController()

@property (nonatomic, strong) ZooMockApiListView *detailView;
@property (nonatomic, assign) CGFloat padding_left;

@end

@implementation ZooMockAPIViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.searchView.textField.text = [ZooMockManager sharedInstance].mockSearchText;
    
    _detailView = [[ZooMockApiListView alloc] initWithFrame:CGRectMake(0, self.sepeatorLine.zoo_bottom, self.view.zoo_width, self.view.zoo_height - self.sepeatorLine.zoo_bottom)];
    [self.view addSubview:_detailView];
    
    NSString *leftTitle = [ZooMockManager sharedInstance].mockGroup;
    if ([leftTitle isEqualToString:@"所有"]) {
        leftTitle = @"接口分组";
    }
    [self.leftButton renderUIWithTitle:leftTitle];
    
    NSString *rightTitle = [ZooMockManager sharedInstance].mockState;
    if ([rightTitle isEqualToString:@"所有"]) {
        rightTitle = @"开关状态";
    }
    [self.rightButton renderUIWithTitle:rightTitle];
}

#pragma mark --ZooMockFilterBgroundDelegate
- (void)filterSelectedClick{
    if(self.rightButton.down){
        NSString *rightTitle = [ZooMockManager sharedInstance].states[self.listView.selectedIndex];
        [ZooMockManager sharedInstance].mockState = rightTitle;
        if ([rightTitle isEqualToString:@"所有"]) {
            rightTitle = @"开关状态";
        }
        [self.rightButton renderUIWithTitle:rightTitle];
    }else{
        NSString *leftTitle = [ZooMockManager sharedInstance].groups[self.listView.selectedIndex];
        [ZooMockManager sharedInstance].mockGroup = leftTitle;
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
    [ZooMockManager sharedInstance].mockSearchText = text;
    [self.detailView reloadUI];
}


@end
