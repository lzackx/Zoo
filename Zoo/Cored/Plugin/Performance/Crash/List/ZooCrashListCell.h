//
//  ZooCrashListCell.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import <UIKit/UIKit.h>

@class ZooSandboxModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZooCrashListCell : UITableViewCell

- (void)renderUIWithData:(ZooSandboxModel *)model;

+ (CGFloat)cellHeight;

@end

NS_ASSUME_NONNULL_END
