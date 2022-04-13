//
//  ZooSandboxCell.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <UIKit/UIKit.h>
@class ZooSandboxModel;

@interface ZooSandBoxCell : UITableViewCell

- (void)renderUIWithData : (ZooSandboxModel *)model;

+ (CGFloat)cellHeight;

@end
