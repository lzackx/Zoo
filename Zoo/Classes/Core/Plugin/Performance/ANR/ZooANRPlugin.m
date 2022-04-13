//
//  ZooANRPlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooANRPlugin.h"
#import "ZooANRViewController.h"
#import "ZooHomeWindow.h"

@implementation ZooANRPlugin

- (void)pluginDidLoad{
    ZooANRViewController *vc = [[ZooANRViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
