//
//  ZooCacheManager.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <Foundation/Foundation.h>

@interface ZooCacheManager : NSObject

+ (ZooCacheManager *)sharedInstance;

// 内存泄漏开关
- (void)saveMemoryLeak:(BOOL)on;
- (BOOL)memoryLeak;

// 内存泄漏弹框开关
- (void)saveMemoryLeakAlert:(BOOL)on;
- (BOOL)memoryLeakAlert;

- (void)saveAllTestSwitch:(BOOL)on;

- (BOOL)allTestSwitch;

// mockapi本地缓存情况
- (void)saveMockCache:(NSArray *)mocks;
- (NSArray *)mockCahce;

// 健康体检开关
- (void)saveHealthStart:(BOOL)on;
- (BOOL)healthStart;

// Kit Manager数据保存
- (void)saveKitManagerData:(NSMutableArray *)dataArray;
- (NSMutableArray *)kitManagerData;
- (NSMutableArray *)kitShowManagerData;
- (NSMutableArray *)allKitShowManagerData;
@end
