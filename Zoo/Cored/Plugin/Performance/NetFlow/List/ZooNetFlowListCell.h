//
//  ZooNetFlowListCell.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import <UIKit/UIKit.h>
#import "ZooNetFlowHttpModel.h"

@interface ZooNetFlowListCell : UITableViewCell

- (void)renderCellWithModel:(ZooNetFlowHttpModel *)httpModel;

+ (CGFloat)cellHeightWithModel:(ZooNetFlowHttpModel *)httpModel;

@end
