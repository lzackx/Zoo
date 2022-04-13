//
//  ZooAppInfoPlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooAppInfoPlugin.h"
#import "ZooHomeWindow.h"
#import "ZooAppInfoViewController.h"

@implementation ZooAppInfoPlugin

- (void)pluginDidLoad{
    ZooAppInfoViewController *vc = [[ZooAppInfoViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
