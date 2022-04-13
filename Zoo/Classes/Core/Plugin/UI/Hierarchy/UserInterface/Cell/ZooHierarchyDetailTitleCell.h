//
//  ZooHierarchyDetailTitleCell.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import "ZooHierarchyTitleCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZooHierarchyDetailTitleCell : ZooHierarchyTitleCell

@property (nonatomic, strong, readonly) UILabel *detailLabel;

@property (nonatomic, strong, readonly) NSLayoutConstraint *detailLabelRightCons;

@end

NS_ASSUME_NONNULL_END
