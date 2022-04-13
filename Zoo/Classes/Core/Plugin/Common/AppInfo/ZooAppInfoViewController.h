//
//  ZooAppInfoViewController.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import "ZooBaseViewController.h"

@interface ZooAppInfoViewController : ZooBaseViewController

/// 自定义App信息处理
@property (class, nonatomic, copy) void (^customAppInfoBlock)(NSMutableArray<NSDictionary *> *appInfos);

@end
