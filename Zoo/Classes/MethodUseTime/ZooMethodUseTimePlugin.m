//
//  ZooMethodUseTimePlugin.m
//  DoraemonKit
//
//  Created by yixiang on 2019/1/18.
//

#import "ZooMethodUseTimePlugin.h"
#import "ZooHomeWindow.h"
#import "ZooMethodUseTimeViewController.h"

@implementation ZooMethodUseTimePlugin

- (void)pluginDidLoad{
    ZooMethodUseTimeViewController *vc = [[ZooMethodUseTimeViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
