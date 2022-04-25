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

// MARK: - MemoryLeak
- (void)addMemoryLeakPlugins;

@end

NS_ASSUME_NONNULL_END
