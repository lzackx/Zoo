//
//  ZooCocoaLumberjackListCell.h
//  DoraemonKit
//
//  Created by yixiang on 2018/12/6.
//

#import <UIKit/UIKit.h>
#import "ZooDDLogMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZooCocoaLumberjackListCell : UITableViewCell

- (void)renderCellWithData:(ZooDDLogMessage *)model;

+ (CGFloat)cellHeightWith:(nullable ZooDDLogMessage *)model;

@end

NS_ASSUME_NONNULL_END
