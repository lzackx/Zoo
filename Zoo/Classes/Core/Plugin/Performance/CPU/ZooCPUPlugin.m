//
//  ZooCPUPlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooCPUPlugin.h"
#import "ZooCPUViewController.h"
#import "ZooHomeWindow.h"

@implementation ZooCPUPlugin

- (void)pluginDidLoad{
    ZooCPUViewController *vc = [[ZooCPUViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
