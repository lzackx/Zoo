//
//  UITouch+MemoryLeak.m
//  MLeaksFinder
//
//  Created by lZackx on 2022/4/14.  Copyright © 2016 zeposhe. All rights reserved.
//

#import "UITouch+MemoryLeak.h"
#import <objc/runtime.h>
#import "ZooCacheManager.h"

#if _INTERNAL_MLF_ENABLED

extern const void *const kLatestSenderKey;

@implementation UITouch (MemoryLeak)

+ (void)load {
    if ([[ZooCacheManager sharedInstance]  memoryLeak]){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self swizzleSEL:@selector(setView:) withSEL:@selector(swizzled_setView:)];
        });
    }
}

- (void)swizzled_setView:(UIView *)view {
    [self swizzled_setView:view];
    
    if (view) {
        objc_setAssociatedObject([UIApplication sharedApplication],
                                 kLatestSenderKey,
                                 @((uintptr_t)view),
                                 OBJC_ASSOCIATION_RETAIN);
    }
}

@end

#endif
