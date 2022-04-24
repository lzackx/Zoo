//
//  ZooCacheManager.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ZooCacheManager : NSObject

+ (ZooCacheManager *)sharedInstance;

- (void)saveMockGPSSwitch:(BOOL)on;

- (BOOL)mockGPSSwitch;

- (void)saveMockCoordinate:(CLLocationCoordinate2D)coordinate;

- (CLLocationCoordinate2D)mockCoordinate;

- (void)saveFpsSwitch:(BOOL)on;

- (BOOL)fpsSwitch;

- (void)saveCpuSwitch:(BOOL)on;

- (BOOL)cpuSwitch;

- (void)saveMemorySwitch:(BOOL)on;

- (BOOL)memorySwitch;

- (void)saveNetFlowSwitch:(BOOL)on;

- (BOOL)netFlowSwitch;

- (void)saveAllTestSwitch:(BOOL)on;

- (BOOL)allTestSwitch;

- (void)saveLargeImageDetectionSwitch:(BOOL)on;

- (BOOL)largeImageDetectionSwitch;

- (void)saveSubThreadUICheckSwitch:(BOOL)on;

- (BOOL)subThreadUICheckSwitch;

- (void)saveMethodUseTimeSwitch:(BOOL)on;

- (BOOL)methodUseTimeSwitch;

- (void)saveStartTimeSwitch:(BOOL)on;

- (BOOL)startTimeSwitch;

- (void)saveANRTrackSwitch:(BOOL)on;

- (BOOL)anrTrackSwitch;

/// 保存启动类
- (void)saveStartClass : (NSString *)startClass;
- (NSString *)startClass;

// 内存泄漏开关
- (void)saveMemoryLeak:(BOOL)on;
- (BOOL)memoryLeak;

// 内存泄漏弹框开关
- (void)saveMemoryLeakAlert:(BOOL)on;
- (BOOL)memoryLeakAlert;

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
