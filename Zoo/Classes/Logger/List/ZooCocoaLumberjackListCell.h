//
//  ZooCocoaLumberjackListCell.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <UIKit/UIKit.h>
#import "ZooDDLogMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZooCocoaLumberjackListCell : UITableViewCell

- (void)renderCellWithData:(ZooDDLogMessage *)model;

+ (CGFloat)cellHeightWith:(nullable ZooDDLogMessage *)model;

@end

NS_ASSUME_NONNULL_END
