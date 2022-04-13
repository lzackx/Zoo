//
//  ZooNSUserDefaultsPlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import "ZooNSUserDefaultsPlugin.h"
#import "ZooNSUserDefaultsViewController.h"
#import "ZooHomeWindow.h"

@implementation ZooNSUserDefaultsPlugin
- (void)pluginDidLoad{
    ZooNSUserDefaultsViewController *vc = [[ZooNSUserDefaultsViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
