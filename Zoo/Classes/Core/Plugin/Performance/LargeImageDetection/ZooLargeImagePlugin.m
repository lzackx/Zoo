//
//  ZooLargeImagePlugin.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooLargeImagePlugin.h"
#import "ZooLargeImageViewController.h"
#import "ZooHomeWindow.h"

@implementation ZooLargeImagePlugin
- (void)pluginDidLoad {
    ZooLargeImageViewController *vc = [[ZooLargeImageViewController alloc] init];
    [ZooHomeWindow openPlugin:vc];
}

@end
