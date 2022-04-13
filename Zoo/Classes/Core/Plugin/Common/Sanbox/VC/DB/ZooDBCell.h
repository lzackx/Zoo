//
//  ZooDBCell.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <UIKit/UIKit.h>
#import "ZooDBRowView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZooDBCell : UITableViewCell

@property (nonatomic, strong) ZooDBRowView *rowView;

- (void)renderCellWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
