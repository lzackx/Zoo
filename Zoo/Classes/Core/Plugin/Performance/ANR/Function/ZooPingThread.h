//
//  ZooPingThread.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

// 参考ONEANRTracker

#import <Foundation/Foundation.h>

typedef void (^ZooANRTrackerBlock)(NSDictionary *info);

/**
 *  用于Ping主线程的线程类
 *  通过信号量控制来Ping主线程，判断主线程是否卡顿
 */
@interface ZooPingThread : NSThread

/**
 *  初始化Ping主线程的线程类
 *
 *  @param threshold 主线程卡顿阈值
 *  @param handler   监控到卡顿回调
 */
- (instancetype)initWithThreshold:(double)threshold
                          handler:(ZooANRTrackerBlock)handler;

@end
