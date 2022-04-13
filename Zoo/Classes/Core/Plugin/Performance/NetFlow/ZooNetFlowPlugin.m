//
//  ZooNetFlowPlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import "ZooNetFlowPlugin.h"
#import "ZooHomeWindow.h"
#import "ZooNetFlowViewController.h"

@implementation ZooNetFlowPlugin

- (void)pluginDidLoad{
    ZooNetFlowViewController *vc = [[ZooNetFlowViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
