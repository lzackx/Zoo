//
//  ZooMockPlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooMockPlugin.h"
#import "ZooMockViewController.h"
#import "ZooHomeWindow.h"
#import "ZooManager.h"
#import "ZooToastUtil.h"
#import "UIViewController+Zoo.h"
#import "Zooi18NUtil.h"

@implementation ZooMockPlugin

- (void)pluginDidLoad{
    ZooMockViewController *vc = [[ZooMockViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
