//
//  ZooMLeaksFinderListViewController.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooMLeaksFinderListViewController.h"
#import "ZooMemoryLeakData.h"
#import "ZooDefine.h"
#import "ZooMLeaksFinderListCell.h"
#import "ZooMLeaksFinderDetailViewController.h"

@interface ZooMLeaksFinderListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation ZooMLeaksFinderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = ZooLocalizedString(@"内存泄漏检测结果");
    
    _dataArray = [ NSArray arrayWithArray:[[ZooMemoryLeakData shareInstance] getResult]];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.zoo_width, self.view.zoo_height) style:UITableViewStylePlain];
//    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZooMLeaksFinderListCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"ZooMLeaksFinderListCellID";
    ZooMLeaksFinderListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[ZooMLeaksFinderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    NSDictionary* dic = [_dataArray objectAtIndex:indexPath.row];
    [cell renderCellWithData:dic];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* dic = [_dataArray objectAtIndex:indexPath.row];
    ZooMLeaksFinderDetailViewController *vc = [[ZooMLeaksFinderDetailViewController alloc] init];
    vc.info = dic;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
