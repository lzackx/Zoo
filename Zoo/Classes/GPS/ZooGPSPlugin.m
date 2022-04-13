//
//  ZooGPSPlugin.m
//  DoraemonKit
//
//  Created by yixiang on 2017/12/20.
//

#import "ZooGPSPlugin.h"
#import "ZooGPSViewController.h"
#import "ZooHomeWindow.h"

@implementation ZooGPSPlugin

- (void)pluginDidLoad{
    ZooGPSViewController *vc = [[ZooGPSViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
