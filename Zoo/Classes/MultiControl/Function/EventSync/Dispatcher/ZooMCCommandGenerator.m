//
//  ZooMCCommandGenerator.m
//  DoraemonKit-DoraemonKit
//
//  Created by litianhao on 2021/7/12.
//

#import "ZooMCCommandGenerator.h"
#import "DoraemonMCMessagePackager.h"
#import "ZooMCServer.h"

@implementation ZooMCCommandGenerator

+ (void)sendMessageWithView:(UIView *)view
                                   gusture:(UIGestureRecognizer *)gusture
                                    action:(SEL)action
                                 indexPath:(NSIndexPath *)indexPath
                               messageType:(DoraemonMCMessageType)type {
    @autoreleasepool {
        ZooMCMessage *message = [DoraemonMCMessagePackager packageMessageWithView:view
                                                                               gusture:gusture
                                                                                action:action
                                                                             indexPath:indexPath
                                                                           messageType:type];
        if (message) {
            [ZooMCServer sendMessage:message.toMessageString];
        }
        message = nil;
    }

}


+ (ZooMCMessage *)sendCustomMessageWithView:(UIView *)view
                                       eventInfo:(NSDictionary *)eventInfo
                                     messageType:(NSString *)type {
    
    ZooMCMessage *message = [DoraemonMCMessagePackager packageCustomMessageWithView:view
                                                                               eventInfo:eventInfo
                                                                             messageType:type];
    
    [ZooMCServer sendMessage:message.toMessageString];
    return message;
}
@end

