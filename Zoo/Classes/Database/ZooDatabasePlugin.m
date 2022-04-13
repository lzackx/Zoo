//
//  ZooDatabasePlugin.m
//  DoraemonKit
//
//  Created by wentian on 2019/7/11.
//

#import "ZooDatabasePlugin.h"
#import "ZooHomeWindow.h"
#import "ZooDatabaseViewController.h"

@implementation ZooDatabasePlugin

- (void)pluginDidLoad{
    ZooDatabaseViewController *vc = [[ZooDatabaseViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
