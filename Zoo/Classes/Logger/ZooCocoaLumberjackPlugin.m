//
//  ZooCocoaLumberjackPlugin.m
//  DoraemonKit
//
//  Created by yixiang on 2018/12/4.
//

#import "ZooCocoaLumberjackPlugin.h"
#import "ZooHomeWindow.h"
#import "ZooCocoaLumberjackViewController.h"

@implementation ZooCocoaLumberjackPlugin

- (void)pluginDidLoad{
    ZooCocoaLumberjackViewController *vc = [[ZooCocoaLumberjackViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
