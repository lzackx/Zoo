//
//  ZooViewAlignPlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooViewAlignPlugin.h"
#import "ZooViewAlignManager.h"
#import "ZooHomeWindow.h"


@implementation ZooViewAlignPlugin

- (void)pluginDidLoad{
    [[ZooViewAlignManager shareInstance] show];
    [[ZooHomeWindow shareInstance] hide];
}

@end
