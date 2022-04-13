//
//  ZooWeakNetworkPlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import "ZooWeakNetworkPlugin.h"
#import "ZooWeakNetworkViewController.h"
#import "ZooHomeWindow.h"

@implementation ZooWeakNetworkPlugin

- (void)pluginDidLoad{
    ZooWeakNetworkViewController *vc = [[ZooWeakNetworkViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
