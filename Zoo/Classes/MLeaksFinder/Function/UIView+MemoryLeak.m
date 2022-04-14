//
//  UIView+MemoryLeak.m
//  MLeaksFinder
//
//  Created by lZackx on 2022/4/14.  Copyright © 2015 zeposhe. All rights reserved.
//

#import "UIView+MemoryLeak.h"
#import "NSObject+MemoryLeak.h"

#if _INTERNAL_MLF_ENABLED

@implementation UIView (MemoryLeak)

- (BOOL)willDealloc {
    if (![super willDealloc]) {
        return NO;
    }
    
    [self willReleaseChildren:self.subviews];
    
    return YES;
}

@end

#endif
