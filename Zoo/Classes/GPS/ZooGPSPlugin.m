//
//  ZooGPSPlugin.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooGPSPlugin.h"
#import "ZooGPSViewController.h"
#import "ZooHomeWindow.h"

@implementation ZooGPSPlugin

- (void)pluginDidLoad{
    ZooGPSViewController *vc = [[ZooGPSViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
