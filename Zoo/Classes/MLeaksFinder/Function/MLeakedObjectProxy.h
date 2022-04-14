//
//  MLeakedObjectProxy.h
//  MLeaksFinder
//
//  Created by lZackx on 2022/4/14.  Copyright © 2016 zeposhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLeakedObjectProxy : NSObject

+ (BOOL)isAnyObjectLeakedAtPtrs:(NSSet *)ptrs;
+ (void)addLeakedObject:(id)object;

@end
