//
//  ZooSandboxPlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooSandboxPlugin.h"
#import "ZooSandboxViewController.h"
#import "ZooHomeWindow.h"

@implementation ZooSandboxPlugin

- (void)pluginDidLoad{
    ZooSandboxViewController *vc = [[ZooSandboxViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
