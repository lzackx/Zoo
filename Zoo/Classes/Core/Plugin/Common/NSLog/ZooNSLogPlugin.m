//
//  ZooNSLogPlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooNSLogPlugin.h"
#import "ZooHomeWindow.h"
#import "ZooNSLogViewController.h"

@implementation ZooNSLogPlugin

- (void)pluginDidLoad{
    ZooNSLogViewController *vc = [[ZooNSLogViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
