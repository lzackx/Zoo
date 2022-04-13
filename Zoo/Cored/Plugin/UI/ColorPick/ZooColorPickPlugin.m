//
//  ZooColorPickPlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import "ZooColorPickPlugin.h"
#import "ZooColorPickWindow.h"
#import "ZooHomeWindow.h"
#import "ZooColorPickInfoWindow.h"

@implementation ZooColorPickPlugin

- (void)pluginDidLoad {
    [[ZooColorPickWindow shareInstance] show];
    [[ZooColorPickInfoWindow shareInstance] show];
    [[ZooHomeWindow shareInstance] hide];
}

@end
