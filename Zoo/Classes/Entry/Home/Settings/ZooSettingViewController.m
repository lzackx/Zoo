//
//  ZooSettingViewController.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooSettingViewController.h"
#import "ZooDefine.h"
#import "ZooCellButton.h"
#import "ZooManagerViewController.h"
#import "ZooSettingCell.h"
#import "ZooDefaultWebViewController.h"
#import "UIViewController+Zoo.h"

@interface ZooSettingViewController ()<ZooCellButtonDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ZooCellButton *kitManagerBtn;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation ZooSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = ZooLocalizedString(@"更多");
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self loadData];
    [self.tableView registerClass:[ZooSettingCell class] forCellReuseIdentifier:@"zoo.setting.cell"];
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = [self fullscreen];
}

- (void)loadData {
    NSString *dataString = @" \
        { \
            \"data\": { \
                \"group\": [ \
                    { \
                        \"group\": \"本地功能\", \
                        \"list\": [ \
                            { \
                                \"type\": \"native\", \
                                \"name\": \"功能管理\", \
                                \"desc\": \"介绍:可以针对内置工具列表进行自定义排序\", \
                            } \
                        ] \
                    } \
                ] \
            }, \
        } \
        ";
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *d = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.dataArr = [[d objectForKey:@"data"] objectForKey:@"group"];
}

#pragma mark -- ZooCellButtonDelegate
- (void)cellBtnClick:(id)sender{
    ZooManagerViewController *vc = [[ZooManagerViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *listArr = [self.dataArr[section] objectForKey:@"list"];
    return listArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZooSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zoo.setting.cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.cellData = self.dataArr[indexPath.section][@"list"][indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.dataArr[section] objectForKey:@"group"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *cellData = self.dataArr[indexPath.section][@"list"][indexPath.row];
    
    if ([[cellData objectForKey:@"type"] isEqualToString:@"native"]) {
        ZooManagerViewController *vc = [[ZooManagerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([[cellData objectForKey:@"type"] isEqualToString:@"web"]) {
        ZooDefaultWebViewController *webVc = [[ZooDefaultWebViewController alloc] init];
        webVc.h5Url = cellData[@"link"];
        [self.navigationController pushViewController:webVc animated:YES];
    }
}
#pragma mark -- Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    }
    return _tableView;
}

@end
