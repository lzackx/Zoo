//
//  ZooMultiCaseListViewController.h
//  DoraemonKit
//
//  Created by wzp on 2021/10/9.
//

#import "ZooBaseViewController.h"
#import "DoraemMultiCaseListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZooMultiCaseListViewController : ZooBaseViewController

@end

@interface DoraemonCaseListCell : UITableViewCell

- (void)renderUIWithData:(DoraemMultiCaseListModel *)data;

+ (CGFloat)cellHeight;


@end

NS_ASSUME_NONNULL_END
