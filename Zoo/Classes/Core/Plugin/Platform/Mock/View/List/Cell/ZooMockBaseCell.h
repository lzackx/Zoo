//
//  ZooMockBaseCell.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <UIKit/UIKit.h>
#import "ZooMockBaseModel.h"
#import "ZooDefine.h"
#import "ZooMockDetailSwitch.h"
#import "ZooMockUpLoadModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZooMockBaseCellDelegate<NSObject>

@optional
- (void)cellExpandClick;
- (void)sceneBtnClick;
- (void)cellSwitchClick;
- (void)previewClick:(ZooMockUpLoadModel *)uploadModel;

@end

@interface ZooMockBaseCell : UITableViewCell

@property (nonatomic, weak) id<ZooMockBaseCellDelegate> delegate;
@property (nonatomic, strong) ZooMockBaseModel *model;
@property (nonatomic, strong) ZooMockDetailSwitch *detailSwitch;
@property (nonatomic, strong) UILabel *infoLabel;

- (void)renderCellWithData:(ZooMockBaseModel *)model;

+ (CGFloat)cellHeightWith:(ZooMockBaseModel *)model;


@end

NS_ASSUME_NONNULL_END
