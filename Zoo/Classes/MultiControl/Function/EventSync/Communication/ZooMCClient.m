//
//  ZooMCClient.m
//  DoraemonKit
//
//  Created by litianhao on 2021/6/30.
//

#import "ZooMCClient.h"
#import <SocketRocket/SocketRocket.h>
#import "ZooToastUtil.h"
#import "ZooMCCommandExcutor.h"
#import "ZooHomeWindow.h"
#import "DoraemonManager.h"
#import "UIColor+Doraemon.h"


NSNotificationName DoraemonMCClientStatusChanged = @"DoraemonMCClientStatusChanged";

@interface ZooMCClient () <SRWebSocketDelegate>

@property (strong, nonatomic) SRWebSocket *wsInstance;

@property (assign, nonatomic) BOOL isConnected;

@end

@implementation ZooMCClient

+ (instancetype)shareInstance {
   static  ZooMCClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (BOOL)isConnected {
    return [[self shareInstance] isConnected] ;
}

+ (void)connectWithUrl:(NSString *)url {
    [[self shareInstance] connectWithUrl:url ];
}

+ (void)disConnect {
    [[self shareInstance] disConnect];
}


- (void)disConnect {
    [self.wsInstance close];
    self.wsInstance = nil;
    self.isConnected = NO;
}

- (void)connectWithUrl:(NSString *)url{
    [self disConnect];
    NSURL *URL = [NSURL URLWithString:url];
    self.wsInstance = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:URL]];
    self.wsInstance.delegate = self;
    [self.wsInstance open];
}



- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    self.isConnected = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showToast:@"连接成功"];
        [[DoraemonManager shareInstance] configEntryBtnBlingWithText:@"从" backColor:[UIColor doraemon_blue]];
    });
    [[NSNotificationCenter defaultCenter] postNotificationName:DoraemonMCClientStatusChanged object:nil];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    [ZooMCCommandExcutor excuteMessageStrFromNet:message];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    self.isConnected = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showToast:error.localizedDescription];
        [[DoraemonManager shareInstance] configEntryBtnBlingWithText:nil backColor:nil];
    });
    [[NSNotificationCenter defaultCenter] postNotificationName:DoraemonMCClientStatusChanged object:nil];
}
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    self.isConnected = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showToast:@"一机多控连接关闭"];
        [[DoraemonManager shareInstance] configEntryBtnBlingWithText:nil backColor:nil];
    });
    [[NSNotificationCenter defaultCenter] postNotificationName:DoraemonMCClientStatusChanged object:nil];
}


+ (void)showToast:(NSString *)toastContent {
    [[self shareInstance] showToast:toastContent];
}
- (void)showToast:(NSString *)toastContent {
    if (![toastContent isKindOfClass:[NSString class]] ||
        toastContent.length == 0) {
        return;
    }
    UIWindow *currentWindow = nil;
    if ([ZooHomeWindow shareInstance].hidden) {
        currentWindow = [UIApplication sharedApplication].keyWindow;
    }else {
        currentWindow = [ZooHomeWindow shareInstance];
    }
    if ([NSThread currentThread].isMainThread) {
        [ZooToastUtil showToastBlack:toastContent inView:currentWindow];
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZooToastUtil showToastBlack:toastContent inView:currentWindow];
        });
    }
}

@end
