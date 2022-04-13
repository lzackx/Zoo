//
//  ZooMCCommandExcutor.h
//  DoraemonKit-DoraemonKit
//
//  Created by litianhao on 2021/7/12.
//

#import <Foundation/Foundation.h>
#import "DoraemonMCMessagePackager.h"
#import "ZooMCEventHandler.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZooMCCommandExcutor : NSObject

+ (void)excuteMessageStrFromNet:(NSString *)message;


+ (void)excuteMessage:(ZooMCMessage *)message;


//增加自定义事件
+ (void)addCustomMessage:(NSString *)type eventHandlerName:(ZooMCEventHandler *)eventHandler;

@end

NS_ASSUME_NONNULL_END
