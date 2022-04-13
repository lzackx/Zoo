//
//  ZooMockBaseViewController.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooMockBaseViewController.h"
#import "ZooDefine.h"
#import "ZooMockManager.h"

@interface ZooMockBaseViewController ()<ZooMockSearchViewDelegate,ZooMockFilterButtonDelegate,ZooMockFilterBgroundDelegate>
@property (nonatomic, assign) CGFloat padding_left;

@end

@implementation ZooMockBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = ZooLocalizedString(@"Mock数据");
    _padding_left = kZooSizeFrom750_Landscape(32);
    _searchView = [[ZooMockSearchView alloc] initWithFrame:CGRectMake(_padding_left, self.bigTitleView.zoo_bottom + _padding_left, self.view.zoo_width-2* _padding_left, kZooSizeFrom750_Landscape(100))];
    _searchView.delegate = self;
    [self.view addSubview:_searchView];
    
    _leftButton = [[ZooMockFilterButton alloc] initWithFrame:CGRectMake(0, _searchView.zoo_bottom, self.view.zoo_width/2, kZooSizeFrom750_Landscape(126))];
    [_leftButton renderUIWithTitle:ZooLocalizedString(@"接口分组")];
    _leftButton.delegate = self;
    _leftButton.tag = 0;
    [self.view addSubview:_leftButton];

    _rightButton = [[ZooMockFilterButton alloc] initWithFrame:CGRectMake(_leftButton.zoo_right, _searchView.zoo_bottom, self.view.zoo_width/2, kZooSizeFrom750_Landscape(126))];
    [_rightButton renderUIWithTitle:ZooLocalizedString(@"开关状态")];
    _rightButton.delegate = self;
    _rightButton.tag = 1;
    [self.view addSubview:_rightButton];

    _listView = [[ZooMockFilterListView alloc] initWithFrame:CGRectMake(0, _leftButton.zoo_bottom, self.view.zoo_width, self.view.zoo_height - _leftButton.zoo_bottom)];
    _listView.delegate = self;
    [self.view addSubview:_listView];

    _sepeatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, _leftButton.zoo_bottom, self.view.zoo_width, kZooSizeFrom750_Landscape(12))];
    _sepeatorLine.backgroundColor = [UIColor zoo_bg];
    [self.view addSubview:_sepeatorLine];
}

- (BOOL)needBigTitleView{
    return YES;
}

- (void)showList:(ZooMockFilterButton *)filterBtn{
    _listView.tag = filterBtn.tag;
    _listView.selectedIndex = filterBtn.selectedItemIndex;
    [self.view addSubview:_listView];
    [_listView showList: [self getItemArray:filterBtn.tag]];
}

- (NSArray *)getItemArray:(NSInteger)tag{
    NSArray *dataArray;
    if (tag == 0) {
        dataArray = [ZooMockManager sharedInstance].groups;
    }else{
        dataArray = [ZooMockManager sharedInstance].states;
    }
    return dataArray;
}

- (void)closeList{
    if(_rightButton.down){
        _rightButton.selectedItemIndex = _listView.selectedIndex;
        [_rightButton setDropdown:NO];
    }else{
        _leftButton.selectedItemIndex = _listView.selectedIndex;
        [_leftButton setDropdown:NO];
    }
    [_listView closeList];
}

#pragma mark - ZooMockSearchViewDelegate
- (void)searchViewInputChange:(NSString *)text{
    
}

#pragma mark --ZooMockFilterBgroundDelegate
- (void)filterBgroundClick{
    [self closeList];
}

#pragma mark --ZooMockFilterBgroundDelegate
- (void)filterSelectedClick{
    [self closeList];
}

#pragma mark - ZooMockHalfButton
- (void)filterBtnClick:(id)sender{
    if(_rightButton.down&&_leftButton.down){
        if(sender==_rightButton){
            _leftButton.selectedItemIndex = _listView.selectedIndex;
            [self showList:_rightButton];
            [_leftButton setDropdown:NO];
            return;
        }
        _rightButton.selectedItemIndex = _listView.selectedIndex;
        [self showList:_leftButton];
        [_rightButton setDropdown:NO];
    }
    else if(_rightButton.down){
        [self showList:_rightButton];
    }
    else if(_leftButton.down){
        [self showList:_leftButton];
    }else{
        if(sender==_leftButton){
            _leftButton.selectedItemIndex = _listView.selectedIndex;
        }
        else{
            _rightButton.selectedItemIndex = _listView.selectedIndex;
        }
        [_listView closeList];
    }
}

@end
