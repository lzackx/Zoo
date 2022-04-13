//
//  ZooSubThreadUICheckPlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooSubThreadUICheckPlugin.h"
#import "ZooSubThreadUICheckViewController.h"
#import "ZooHomeWindow.h"

@implementation ZooSubThreadUICheckPlugin

- (void)pluginDidLoad{
    ZooSubThreadUICheckViewController *vc = [[ZooSubThreadUICheckViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
