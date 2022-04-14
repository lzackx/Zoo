//
//  ZooMemoryLeakData.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ZooLeakManagerBlock)(NSDictionary *leakInfo);

@interface ZooMemoryLeakData : NSObject

+ (ZooMemoryLeakData *)shareInstance;

- (void)addLeakBlock:(ZooLeakManagerBlock)block;

- (void)addObject:(id)object;

- (void)removeObjectPtr:(NSNumber *)objectPtr;

- (NSArray *)getResult;

- (void)clearResult;

@end

NS_ASSUME_NONNULL_END
