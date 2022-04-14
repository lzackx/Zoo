//
//  ZooCocoaLumberjackLogger.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <CocoaLumberjack/DDLog.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooCocoaLumberjackLogger : DDAbstractLogger

+ (instancetype)sharedInstance;

- (void)startMonitor;

- (void)stopMonitor;

@property (nonatomic, strong) dispatch_queue_t consoleQueue;
@property (nonatomic, strong) NSMutableArray *messages; 

@end

NS_ASSUME_NONNULL_END
