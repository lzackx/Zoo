//
//  ZooMCViewController.h
//  DoraemonKit-DoraemonKit
//
//  Created by litianhao on 2021/7/12.
//

#import "ZooBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger , DoraemonMCViewControllerWorkMode) {
    DoraemonMCViewControllerWorkModeNone,
    DoraemonMCViewControllerWorkModeServer,
    DoraemonMCViewControllerWorkModeClient
};

@interface ZooMCViewController : ZooBaseViewController

@end

NS_ASSUME_NONNULL_END
