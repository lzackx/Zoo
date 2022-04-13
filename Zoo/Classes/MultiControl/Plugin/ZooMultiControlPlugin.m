//
//  ZooMultiControlPlugin.m
//  DoraemonKit-DoraemonKit
//
//  Created by litianhao on 2021/7/12.
//

#import "ZooMultiControlPlugin.h"
#import "ZooHomeWindow.h"
#import "DoraemonDefine.h"
#import "DoraemonManager.h"
#import "ZooMCViewController.h"
#import "ZooMCClient.h"
#import "ZooMCServer.h"


@implementation ZooMultiControlPlugin

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UIApplicationDidFinishLaunchingNotificationDeal) name:UIApplicationDidFinishLaunchingNotification object:nil];
    });
}


+ (void)UIApplicationDidFinishLaunchingNotificationDeal {
  [[DoraemonManager shareInstance] addPluginWithTitle:DoraemonLocalizedString(@"一机多控")
                                                 icon:@"dk_icon_mc"
                                                 desc:@"一机多控入口"
                                           pluginName:@"一机多控"
                                             atModule:DoraemonLocalizedString(@"平台工具")
                                               handle:^(NSDictionary * _Nonnull itemData) {
      ZooMCViewController *toolVC = [ZooMCViewController new];
      [ZooHomeWindow openPlugin:toolVC];
      
  }];
}

@end
