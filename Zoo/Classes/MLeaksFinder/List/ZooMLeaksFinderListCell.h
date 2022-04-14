//
//  ZooMLeaksFinderListCell.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooMLeaksFinderListCell : UITableViewCell

- (void)renderCellWithData:(NSDictionary *)dic;

+ (CGFloat)cellHeight;


@end

NS_ASSUME_NONNULL_END
