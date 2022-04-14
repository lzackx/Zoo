//
//  ZooMockApiListView.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooMockApiListView.h"
#import "ZooMockApiCell.h"
#import "ZooMockUtil.h"

@interface ZooMockApiListView()

@end

@implementation ZooMockApiListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.dataArray = [[ZooMockManager sharedInstance] filterMockArray];
    }
    return self;
}

- (void)reloadUI{
    self.dataArray = [[ZooMockManager sharedInstance] filterMockArray];
    [super reloadUI];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZooMockBaseModel* model = [self.dataArray objectAtIndex:indexPath.row];
    return [ZooMockApiCell cellHeightWith:model];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"detailcell";
    ZooMockApiCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[ZooMockApiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.delegate = self;
    }
    ZooMockBaseModel* model = [self.dataArray objectAtIndex:indexPath.row];
    [cell renderCellWithData:model];
    return cell;
}

- (void)cellExpandClick{
    [self.tableView reloadData];
}

- (void)sceneBtnClick{
    [[ZooMockUtil sharedInstance] saveMockArrayCache];
    [self.tableView reloadData];
}

- (void)cellSwitchClick{
    [[ZooMockUtil sharedInstance] saveMockArrayCache];
    [self.tableView reloadData];
}

@end
