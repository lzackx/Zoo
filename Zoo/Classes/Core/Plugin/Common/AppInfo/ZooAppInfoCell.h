//
//  ZooAppInfoCell.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <UIKit/UIKit.h>

@interface ZooAppInfoCell : UITableViewCell

- (void)renderUIWithData:(NSDictionary *)data;

+ (CGFloat)cellHeight;

@end
