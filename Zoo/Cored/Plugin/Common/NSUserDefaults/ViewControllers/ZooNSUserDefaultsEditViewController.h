//
//  ZooNSUserDefaultsEditViewController.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import <Zoo/Zoo.h>
#import "ZooBaseViewController.h"
@class ZooNSUserDefaultsModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZooNSUserDefaultsEditViewController : ZooBaseViewController
@property (nonatomic, strong) ZooNSUserDefaultsModel *model;

- (instancetype)initWithModel: (ZooNSUserDefaultsModel *)model;
@end

NS_ASSUME_NONNULL_END
