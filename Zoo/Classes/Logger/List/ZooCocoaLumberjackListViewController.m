//
//  ZooCocoaLumberjackListViewController.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooCocoaLumberjackListViewController.h"
#import "ZooNSLogSearchView.h"
#import "ZooDefine.h"
#import "ZooCocoaLumberjackLevelView.h"
#import "ZooCocoaLumberjackListCell.h"
#import "ZooDDLogMessage.h"
#import "ZooCocoaLumberjackLogger.h"
#import "ZooNavBarItemModel.h"

@interface ZooCocoaLumberjackListViewController ()<ZooNSLogSearchViewDelegate,ZooCocoaLumberjackLevelViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ZooNSLogSearchView *searchView;
@property (nonatomic, strong) ZooCocoaLumberjackLevelView *levelView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, copy) NSArray *origArray;

@end

@implementation ZooCocoaLumberjackListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = ZooLocalizedString(@"日志记录");
    ZooNavBarItemModel *model1 = [[ZooNavBarItemModel alloc] initWithText:ZooLocalizedString(@"清除") color:[UIColor zoo_blue] selector:@selector(clear)];
    ZooNavBarItemModel *model2 = [[ZooNavBarItemModel alloc] initWithText:ZooLocalizedString(@"导出") color:[UIColor zoo_blue] selector:@selector(export)];
    [self setRightNavBarItems:@[model1,model2]];
    
    self.origArray = [NSArray arrayWithArray:[ZooCocoaLumberjackLogger sharedInstance].messages];
    self.dataArray = [NSArray arrayWithArray:self.origArray];
    
    _searchView = [[ZooNSLogSearchView alloc] initWithFrame:CGRectMake(kZooSizeFrom750_Landscape(32), IPHONE_NAVIGATIONBAR_HEIGHT+kZooSizeFrom750_Landscape(32), self.view.zoo_width-2*kZooSizeFrom750_Landscape(32), kZooSizeFrom750_Landscape(100))];
    _searchView.delegate = self;
    [self.view addSubview:_searchView];
    
    _levelView = [[ZooCocoaLumberjackLevelView alloc] initWithFrame:CGRectMake(0, _searchView.zoo_bottom+kZooSizeFrom750_Landscape(32), self.view.zoo_width, kZooSizeFrom750_Landscape(68))];
    _levelView.delegate = self;
    [self.view addSubview:_levelView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _levelView.zoo_bottom+kZooSizeFrom750_Landscape(32), self.view.zoo_width, self.view.zoo_height-_searchView.zoo_bottom-kZooSizeFrom750_Landscape(32)) style:UITableViewStylePlain];
//    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

- (void)clear {
    [[ZooCocoaLumberjackLogger sharedInstance].messages removeAllObjects];
    self.origArray = @[];
    self.dataArray = @[];
    [self.tableView reloadData];
}

- (void)export {
    NSArray<ZooDDLogMessage *> *dataArray = [[ZooCocoaLumberjackLogger sharedInstance].messages copy];
    NSMutableString *log = [[NSMutableString alloc] init];
    for (ZooDDLogMessage *model in dataArray) {
        NSString *time = [NSString stringWithFormat:@"[%@]",[ZooUtil dateFormatNSDate:model.timestamp]];
        [log appendString:time];
        [log appendString:@" "];
        [log appendString:model.message];
        [log appendString:@"\n"];
    }
    
    [ZooUtil shareText:log formVC:self];
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZooDDLogMessage* model = [self.dataArray objectAtIndex:indexPath.row];
    return [ZooCocoaLumberjackListCell cellHeightWith:model];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"httpcell";
    ZooCocoaLumberjackListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[ZooCocoaLumberjackListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    ZooDDLogMessage* model = [self.dataArray objectAtIndex:indexPath.row];
    [cell renderCellWithData:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZooDDLogMessage* model = [self.dataArray objectAtIndex:indexPath.row];
    model.expand = !model.expand;
    [self.tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ZooLocalizedString(@"复制");
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    ZooDDLogMessage* model = [self.dataArray objectAtIndex:indexPath.row];
    NSString *content = model.message;
    if (content.length>0) {
        UIPasteboard *pboard = [UIPasteboard generalPasteboard];
        pboard.string = content;
    }
}

#pragma mark - ZooNSLogSearchViewDelegate
- (void)searchViewInputChange:(NSString *)text{
    if (text.length > 0) {
        NSArray *dataArray = self.origArray;
        NSMutableArray *resultArray = [[NSMutableArray alloc] init];
        for(ZooDDLogMessage *model in dataArray){
            NSString *content = model.message;
            if ([content containsString:text]) {
                [resultArray addObject:model];
            }
        }
        self.dataArray = [[NSArray alloc] initWithArray:resultArray];
    }else{
        self.dataArray = [[NSArray alloc] initWithArray:self.origArray];
    }
    
    [self.tableView reloadData];
}

#pragma mark - ZooCocoaLumberjackLevelViewDelegate
- (void)segmentSelected:(NSInteger)index{
    NSLog(@"%zi",DDLogFlagError);
    NSLog(@"%zi",DDLogFlagWarning);
    NSLog(@"%zi",DDLogFlagInfo);
    NSLog(@"%zi",DDLogFlagDebug);
    NSLog(@"%zi",DDLogFlagVerbose);
    DDLogFlag flag = DDLogFlagVerbose;
    if (index==0) {
        flag = DDLogFlagVerbose;//16
    }else if(index==1){
        flag = DDLogFlagDebug;//8
    }else if(index==2){
        flag = DDLogFlagInfo;//4
    }else if(index==3){
        flag = DDLogFlagWarning;//2
    }else if(index==4){
        flag = DDLogFlagError;//1
    }
    
    NSArray *dataArray = self.origArray;
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    for(ZooDDLogMessage *model in dataArray){
        DDLogFlag modelFlag = model.flag;
        if (modelFlag <= flag) {
            [resultArray addObject:model];
        }
    }
    self.dataArray = [[NSArray alloc] initWithArray:resultArray];
    [self.tableView reloadData];
    
}


@end
