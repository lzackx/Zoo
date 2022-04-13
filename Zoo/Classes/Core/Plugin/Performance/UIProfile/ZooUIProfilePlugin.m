//
//  ZooUIProfilePlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooUIProfilePlugin.h"
#import "ZooUIProfileViewController.h"
#import "ZooHomeWindow.h"

@implementation ZooUIProfilePlugin

- (void)pluginDidLoad{
    ZooUIProfileViewController *vc = [[ZooUIProfileViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
