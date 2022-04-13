//
//  ZooH5Plugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooH5Plugin.h"
#import "ZooH5ViewController.h"
#import "ZooHomeWindow.h"

@implementation ZooH5Plugin

- (void)pluginDidLoad{
    ZooH5ViewController *vc = [[ZooH5ViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
