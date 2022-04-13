//
//  ZooUIProfileManager.m
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import "ZooUIProfileManager.h"
#import "UIViewController+ZooUIProfile.h"
#import "ZooUIProfileWindow.h"
#import "UIViewController+Zoo.h"

@interface ZooUIProfileManager ()

@end

@implementation ZooUIProfileManager

+ (instancetype)sharedInstance
{
    static ZooUIProfileManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [ZooUIProfileManager new];
    });
    
    return sharedInstance;
}

- (void)setEnable:(BOOL)enable
{
    _enable = enable;
    if (enable) {
        [[UIViewController topViewControllerForKeyWindow] profileViewDepth];
    } else {
        [[UIViewController topViewControllerForKeyWindow] resetProfileData];
        [[ZooUIProfileWindow sharedInstance] hide];
    }
}

@end
