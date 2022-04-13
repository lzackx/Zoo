//
//  ZooImageDetectionCell.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <UIKit/UIKit.h>
@class ZooResponseImageModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZooImageDetectionCell : UITableViewCell
+ (CGFloat)cellHeight;

- (void)setupWithModel:(ZooResponseImageModel *)model;
@end

NS_ASSUME_NONNULL_END
