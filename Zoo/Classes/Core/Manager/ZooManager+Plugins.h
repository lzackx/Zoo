//
//  ZooManager+Plugins.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZooManager (Plugins)

// MARK: - Core
- (void)addCorePlugins;

// MARK: - Platform
- (void)addPlatformPlugins;

// MARK: - Performance
- (void)addPerformancePlugins;

// MARK: - UI
- (void)addUIPlugins;

// MARK: - GPS
- (void)addGPSPlugins;

// MARK: - Logger
- (void)addLoggerPlugins;

// MARK: - MemoryLeak
- (void)addMemoryLeakPlugins;

@end

NS_ASSUME_NONNULL_END
