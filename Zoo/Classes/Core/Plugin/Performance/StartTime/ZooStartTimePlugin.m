//
//  ZooStartTimePlugin.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooStartTimePlugin.h"
#import "ZooHomeWindow.h"
#import "ZooStartTimeViewController.h"

@implementation ZooStartTimePlugin

- (void)pluginDidLoad{
    ZooStartTimeViewController *vc = [[ZooStartTimeViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
