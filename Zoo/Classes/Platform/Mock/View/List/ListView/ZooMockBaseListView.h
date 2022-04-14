//
//  ZooMockBaseListView.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <UIKit/UIKit.h>
#import "ZooMockBaseModel.h"
#import "ZooMockManager.h"
#import "ZooDefine.h"
#import "ZooMockBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZooMockBaseListView : UIView<ZooMockBaseCellDelegate>

@property (nonatomic, copy) NSArray<ZooMockBaseModel *> *dataArray;
@property (nonatomic, strong) UITableView *tableView;

- (void)reloadUI;

@end

NS_ASSUME_NONNULL_END
