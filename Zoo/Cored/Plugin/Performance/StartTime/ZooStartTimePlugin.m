//
//  ZooStartTimePlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import "ZooStartTimePlugin.h"
#import "ZooHomeWindow.h"
#import "ZooStartTimeViewController.h"

@implementation ZooStartTimePlugin

- (void)pluginDidLoad{
    ZooStartTimeViewController *vc = [[ZooStartTimeViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
