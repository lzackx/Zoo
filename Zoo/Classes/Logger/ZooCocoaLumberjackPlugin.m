//
//  ZooCocoaLumberjackPlugin.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooCocoaLumberjackPlugin.h"
#import "ZooHomeWindow.h"
#import "ZooCocoaLumberjackViewController.h"

@implementation ZooCocoaLumberjackPlugin

- (void)pluginDidLoad{
    ZooCocoaLumberjackViewController *vc = [[ZooCocoaLumberjackViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
