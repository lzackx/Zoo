//
//  ZooMCEventHandler.h
//  DoraemonKit
//
//  Created by litianhao on 2021/6/30.
//


#import <Foundation/Foundation.h>
#import "DoraemonMCMessagePackager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZooMCEventHandler : NSObject

@property (nonatomic , strong) ZooMCMessage *messageInfo;

@property (nonatomic , strong) UIView *targetView;

- (BOOL)handleEvent:(ZooMCMessage*)eventInfo;

- (UIView *)fetchTargetView;

@end

@interface DoraemonMCGestureRecognizerEventHandler : ZooMCEventHandler


@end

@interface DoraemonMCControlEventHandler : ZooMCEventHandler


@end

@interface DoraemonMCReuseCellEventHandler : ZooMCEventHandler



@end

@interface DoraemonMCTextFiledEventHandler : ZooMCEventHandler


@end

@interface DoraemonMCTabbarEventHandler : ZooMCEventHandler


@end

NS_ASSUME_NONNULL_END
