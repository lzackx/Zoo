//
//  ZooMLeaksFinderListCell.h
//  DoraemonKit
//
//  Created by didi on 2019/10/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooMLeaksFinderListCell : UITableViewCell

- (void)renderCellWithData:(NSDictionary *)dic;

+ (CGFloat)cellHeight;


@end

NS_ASSUME_NONNULL_END
