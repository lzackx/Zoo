//
//  ZooMemoryOscillogramWindow.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooMemoryOscillogramWindow.h"
#import "ZooMemoryOscillogramViewController.h"

@implementation ZooMemoryOscillogramWindow

+ (ZooMemoryOscillogramWindow *)shareInstance{
    static dispatch_once_t once;
    static ZooMemoryOscillogramWindow *instance;
    dispatch_once(&once, ^{
        instance = [[ZooMemoryOscillogramWindow alloc] initWithFrame:CGRectZero];
    });
    return instance;
}

- (void)addRootVc{
    ZooMemoryOscillogramViewController *vc = [[ZooMemoryOscillogramViewController alloc] init];
    self.rootViewController = vc;
    self.vc = vc;
}

@end
