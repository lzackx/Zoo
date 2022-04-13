//
//  ZooNetFlowDetailCell.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import <UIKit/UIKit.h>

@interface ZooNetFlowDetailCell : UITableViewCell

- (void)renderUIWithContent:(NSString *)content isFirst:(BOOL)isFirst isLast:(BOOL)isLast;
+ (CGFloat)cellHeightWithContent:(NSString *)content;

@end
