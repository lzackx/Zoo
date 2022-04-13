//
//  ZooViewCheckPlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import "ZooViewCheckPlugin.h"
#import "ZooViewCheckManager.h"
#import "ZooHomeWindow.h"

@implementation ZooViewCheckPlugin

- (void)pluginDidLoad{
    [[ZooViewCheckManager shareInstance] show];
    [[ZooHomeWindow shareInstance] hide];
}

@end
