//
//  ZooHealthPlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooHealthPlugin.h"
#import "ZooHomeWindow.h"
#import "ZooHealthViewController.h"
#import "ZooManager.h"
#import "ZooToastUtil.h"
#import "UIViewController+Zoo.h"
#import "Zooi18NUtil.h"

@implementation ZooHealthPlugin

- (void)pluginDidLoad{
    ZooHealthViewController *vc = [[ZooHealthViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
