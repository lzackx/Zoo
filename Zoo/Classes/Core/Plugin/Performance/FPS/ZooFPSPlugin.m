//
//  ZooFPSPlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooFPSPlugin.h"
#import "ZooFPSViewController.h"
#import "ZooHomeWindow.h"

@implementation ZooFPSPlugin

- (void)pluginDidLoad{
    ZooFPSViewController *vc = [[ZooFPSViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
