//
//  ZooTimeProfilerPlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import "ZooTimeProfilerPlugin.h"
#import "ZooHomeWindow.h"
#import "ZooTimeProfilerViewController.h"

@implementation ZooTimeProfilerPlugin

- (void)pluginDidLoad{
    ZooTimeProfilerViewController *vc = [[ZooTimeProfilerViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
