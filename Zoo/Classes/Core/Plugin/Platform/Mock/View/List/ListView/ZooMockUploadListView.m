//
//  ZooMockUploadListView.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooMockUploadListView.h"
#import "ZooMockUploadCell.h"
#import "ZooMockUtil.h"

@interface ZooMockUploadListView()

@end

@implementation ZooMockUploadListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.dataArray = [[ZooMockManager sharedInstance] filterUpLoadArray];
    }
    return self;
}

- (void)reloadUI{
    self.dataArray = [[ZooMockManager sharedInstance] filterUpLoadArray];
    [super reloadUI];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZooMockBaseModel* model = [self.dataArray objectAtIndex:indexPath.row];
    return [ZooMockUploadCell cellHeightWith:model];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"detailcell";
    ZooMockUploadCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[ZooMockUploadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.delegate = self;
    }
    ZooMockBaseModel* model = [self.dataArray objectAtIndex:indexPath.row];
    [cell renderCellWithData:model];
    return cell;
}

#pragma mark - ZooMockBaseCellDelegate
- (void)previewClick:(ZooMockUpLoadModel *)uploadModel{
    if (_delegate && [_delegate respondsToSelector:@selector(previewClick:)]) {
        [_delegate previewClick:uploadModel];
    }
}

- (void)cellSwitchClick{
    [[ZooMockUtil sharedInstance] saveUploadArrayCache];
    [self.tableView reloadData];
}
@end
