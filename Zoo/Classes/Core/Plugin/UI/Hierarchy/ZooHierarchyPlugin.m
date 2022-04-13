//
//  ZooHierarchyPlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import "ZooHierarchyPlugin.h"
#import "ZooHierarchyWindow.h"
#import "ZooHierarchyHelper.h"
#import "ZooHomeWindow.h"


@implementation ZooHierarchyPlugin

- (void)pluginDidLoad {
    ZooHierarchyWindow *window = [[ZooHierarchyWindow alloc] init];
    [ZooHierarchyHelper shared].window = window;
    [window show];
    [[ZooHomeWindow shareInstance] hide];
}

@end
