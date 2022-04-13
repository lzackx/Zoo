//
//  ZooAppSettingPlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooAppSettingPlugin.h"
#import "ZooUtil.h"
#import "ZooHomeWindow.h"

@implementation ZooAppSettingPlugin

- (void)pluginDidLoad {
    [ZooUtil openAppSetting];
    [[ZooHomeWindow shareInstance] hide];
}

@end
