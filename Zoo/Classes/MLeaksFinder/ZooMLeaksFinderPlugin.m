//
//  ZooMLeaksFinderPlugin.m
//  DoraemonKit
//
//  Created by didi on 2019/10/6.
//

#import "ZooMLeaksFinderPlugin.h"
#import "ZooHomeWindow.h"
#import "ZooMLeaksFinderViewController.h"

@implementation ZooMLeaksFinderPlugin

- (void)pluginDidLoad{
    ZooMLeaksFinderViewController *vc = [[ZooMLeaksFinderViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
