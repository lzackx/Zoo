//
//  ZooANRListCell.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import <UIKit/UIKit.h>

@class ZooSandboxModel;

@interface ZooANRListCell : UITableViewCell

- (void)renderCellWithData:(ZooSandboxModel *)model;

+ (CGFloat)cellHeight;

@end
