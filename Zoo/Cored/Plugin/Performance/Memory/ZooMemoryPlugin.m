//
//  ZooMemoryPlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import "ZooMemoryPlugin.h"
#import "ZooMemoryViewController.h"
#import "ZooHomeWindow.h"

@implementation ZooMemoryPlugin

- (void)pluginDidLoad{
    ZooMemoryViewController *vc = [[ZooMemoryViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
