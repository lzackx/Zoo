//
//  ZooBacktraceLogger.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define ZooBSLOG NSLog(@"%@",[BSBacktraceLogger bs_backtraceOfCurrentThread]);
#define ZooBSLOG_MAIN NSLog(@"%@",[BSBacktraceLogger bs_backtraceOfMainThread]);
#define ZooBSLOG_ALL NSLog(@"%@",[BSBacktraceLogger bs_backtraceOfAllThread]);

@interface ZooBacktraceLogger : NSObject

+ (NSString *)zoo_backtraceOfAllThread;
+ (NSString *)zoo_backtraceOfCurrentThread;
+ (NSString *)zoo_backtraceOfMainThread;
+ (NSString *)zoo_backtraceOfNSThread:(NSThread *)thread;

@end

NS_ASSUME_NONNULL_END
