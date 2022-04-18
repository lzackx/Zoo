//
//  ZooURLPlugin.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooURLPlugin.h"
#import "ZooURLViewController.h"
#import "ZooHomeWindow.h"

@implementation ZooURLPlugin

- (void)pluginDidLoad{
    ZooURLViewController *vc = [[ZooURLViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
