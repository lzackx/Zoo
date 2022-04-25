//
//  ZooManager+Plugins.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZooManager (Plugins)

// MARK: - Platform
- (void)addPlatformPlugins;

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
