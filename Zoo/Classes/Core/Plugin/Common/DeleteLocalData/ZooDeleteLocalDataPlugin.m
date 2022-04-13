//
//  ZooDeleteLocalDataPlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import "ZooDeleteLocalDataPlugin.h"
#import "ZooHomeWindow.h"
#import "ZooDeleteLocalDataViewController.h"

@implementation ZooDeleteLocalDataPlugin

- (void)pluginDidLoad{
    ZooDeleteLocalDataViewController *vc = [[ZooDeleteLocalDataViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
