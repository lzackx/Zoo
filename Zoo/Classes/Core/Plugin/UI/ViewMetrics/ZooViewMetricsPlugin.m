//
//  ZooViewMetricsPlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooViewMetricsPlugin.h"
#import "ZooMetricsViewController.h"
#import "ZooHomeWindow.h"

@implementation ZooViewMetricsPlugin

- (void)pluginDidLoad{
    ZooMetricsViewController *vc = [[ZooMetricsViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
