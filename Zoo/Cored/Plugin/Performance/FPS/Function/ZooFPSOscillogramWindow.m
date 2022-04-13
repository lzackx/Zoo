//
//  ZooFPSOscillogramWindow.m
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import "ZooFPSOscillogramWindow.h"
#import "ZooFPSOscillogramViewController.h"

@implementation ZooFPSOscillogramWindow

+ (ZooFPSOscillogramWindow *)shareInstance{
    static dispatch_once_t once;
    static ZooFPSOscillogramWindow *instance;
    dispatch_once(&once, ^{
        instance = [[ZooFPSOscillogramWindow alloc] initWithFrame:CGRectZero];
    });
    return instance;
}

- (void)addRootVc{
    ZooFPSOscillogramViewController *vc = [[ZooFPSOscillogramViewController alloc] init];
    self.rootViewController = vc;
    self.vc = vc;
}

@end
