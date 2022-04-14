//
//  MLeakedObjectProxy.m
//  MLeaksFinder
//
//  Created by lZackx on 2022/4/14.  Copyright © 2016 zeposhe. All rights reserved.
//

#import "MLeakedObjectProxy.h"
#import "MLeaksFinder.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "ZooMemoryLeakData.h"
#import "ZooCacheManager.h"
#import "ZooAlertUtil.h"
#import "UIViewController+Zoo.h"
#import "ZooAlertUtil.h"
#import "UIViewController+Zoo.h"

#if _INTERNAL_MLF_RC_ENABLED
#import <FBRetainCycleDetector/FBRetainCycleDetector.h>
#endif

static NSMutableSet *leakedObjectPtrs;

@interface MLeakedObjectProxy ()
@property (nonatomic, weak) id object;
@property (nonatomic, strong) NSNumber *objectPtr;
@property (nonatomic, strong) NSArray *viewStack;
@end

@implementation MLeakedObjectProxy

+ (BOOL)isAnyObjectLeakedAtPtrs:(NSSet *)ptrs {
    NSAssert([NSThread isMainThread], @"Must be in main thread.");
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        leakedObjectPtrs = [[NSMutableSet alloc] init];
    });
    
    if (!ptrs.count) {
        return NO;
    }
    if ([leakedObjectPtrs intersectsSet:ptrs]) {
        return YES;
    } else {
        return NO;
    }
}

+ (void)addLeakedObject:(id)object {
    NSAssert([NSThread isMainThread], @"Must be in main thread.");
    
    MLeakedObjectProxy *proxy = [[MLeakedObjectProxy alloc] init];
    proxy.object = object;
    proxy.objectPtr = @((uintptr_t)object);
    proxy.viewStack = [object viewStack];
    static const void *const kLeakedObjectProxyKey = &kLeakedObjectProxyKey;
    objc_setAssociatedObject(object, kLeakedObjectProxyKey, proxy, OBJC_ASSOCIATION_RETAIN);
    
    [leakedObjectPtrs addObject:proxy.objectPtr];
    [[ZooMemoryLeakData shareInstance] addObject:object];
    
    if ([[ZooCacheManager sharedInstance] memoryLeakAlert]) {
        #if _INTERNAL_MLF_RC_ENABLED
        [ZooAlertUtil handleAlertActionWithVC:[UIViewController rootViewControllerForKeyWindow] title:@"Memory Leak" text:[NSString stringWithFormat:@"%@", proxy.viewStack] ok:@"OK" cancel:@"Retain Cycle" okBlock:^{
            
        } cancleBlock:^{
            [proxy searchRetainCycle];
        }];
        #else
            [ZooAlertUtil handleAlertActionWithVC:[UIViewController rootViewControllerForKeyWindow] title:@"Memory Leak" text:[NSString stringWithFormat:@"%@", proxy.viewStack] ok:@"OK" okBlock:^{

            }];
        #endif
    }
}

- (void)dealloc {
    NSNumber *objectPtr = _objectPtr;
    NSArray *viewStack = _viewStack;
    dispatch_async(dispatch_get_main_queue(), ^{
        [leakedObjectPtrs removeObject:objectPtr];
        [[ZooMemoryLeakData shareInstance] removeObjectPtr:objectPtr];
        [ZooAlertUtil handleAlertActionWithVC:[UIViewController rootViewControllerForKeyWindow] title:@"Object Deallocated" text:[NSString stringWithFormat:@"%@", viewStack] ok:@"OK" okBlock:^{
            
        }];
    });
}

- (void)searchRetainCycle{
    id object = self.object;
    if (!object) {
        return;
    }
        
    #if _INTERNAL_MLF_RC_ENABLED
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
            [detector addCandidate:self.object];
            NSSet *retainCycles = [detector findRetainCyclesWithMaxCycleLength:20];
            
            BOOL hasFound = NO;
            for (NSArray *retainCycle in retainCycles) {
                NSInteger index = 0;
                for (FBObjectiveCGraphElement *element in retainCycle) {
                    if (element.object == object) {
                        NSArray *shiftedRetainCycle = [self shiftArray:retainCycle toIndex:index];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [ZooAlertUtil handleAlertActionWithVC:[UIViewController rootViewControllerForKeyWindow] title:@"Retain Cycle" text:[NSString stringWithFormat:@"%@", shiftedRetainCycle] ok:@"OK" okBlock:^{
                            
                            }];
                        });
                        hasFound = YES;
                        break;
                    }
                    
                    ++index;
                }
                if (hasFound) {
                    break;
                }
            }
            if (!hasFound) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [ZooAlertUtil handleAlertActionWithVC:[UIViewController rootViewControllerForKeyWindow] title:@"Retain Cycle" text:@"Fail to find a retain cycle" ok:@"OK" okBlock:^{
                        
                    }];
                });
            }
        });
    #endif
}

- (NSArray *)shiftArray:(NSArray *)array toIndex:(NSInteger)index {
    if (index == 0) {
        return array;
    }
    
    NSRange range = NSMakeRange(index, array.count - index);
    NSMutableArray *result = [[array subarrayWithRange:range] mutableCopy];
    [result addObjectsFromArray:[array subarrayWithRange:NSMakeRange(0, index)]];
    return result;
}

@end
