//
//  ZooCacheManager.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooCacheManager.h"
#import "ZooManager.h"
#import "ZooDefine.h"



static NSString * const kZooMockGPSSwitchKey = @"zoo_mock_gps_key";
static NSString * const kZooMockCoordinateKey = @"zoo_mock_coordinate_key";
static NSString * const kZooFpsKey = @"zoo_fps_key";
static NSString * const kZooCpuKey = @"zoo_cpu_key";
static NSString * const kZooMemoryKey = @"zoo_memory_key";
static NSString * const kZooNetFlowKey = @"zoo_netflow_key";
static NSString * const kZooSubThreadUICheckKey = @"zoo_sub_thread_ui_check_key";
static NSString * const kZooMethodUseTimeKey = @"zoo_method_use_time_key";
static NSString * const kZooLargeImageDetectionKey = @"zoo_large_image_detection_key";
static NSString * const kZooStartTimeKey = @"zoo_start_time_key";
static NSString * const kZooStartClassKey = @"zoo_start_class_key";
static NSString * const kZooANRTrackKey = @"zoo_anr_track_key";
static NSString * const kZooMemoryLeakKey = @"zoo_memory_leak_key";
static NSString * const kZooMemoryLeakAlertKey = @"zoo_memory_leak_alert_key";
static NSString * const kZooAllTestKey = @"zoo_allTest_window_key";
static NSString * const kZooMockCacheKey = @"zoo_mock_cache_key";
static NSString * const kZooHealthStartKey = @"zoo_health_start_key";
#define kZooManagerKey [NSString stringWithFormat:@"%@_zoo_kit_manager_key", ZooVersion]

@interface ZooCacheManager()

@property (nonatomic, strong) NSUserDefaults *defaults;
@property (nonatomic, assign) BOOL memoryLeakOn;
@property (nonatomic, assign) BOOL firstReadMemoryLeakOn;

@end

@implementation ZooCacheManager

+ (ZooCacheManager *)sharedInstance{
    static dispatch_once_t once;
    static ZooCacheManager *instance;
    dispatch_once(&once, ^{
        instance = [[ZooCacheManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self  = [super init];
    if (self) {
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (void)saveMockGPSSwitch:(BOOL)on{
    [_defaults setBool:on forKey:kZooMockGPSSwitchKey];
    [_defaults synchronize];
}

- (BOOL)mockGPSSwitch{
    return [_defaults boolForKey:kZooMockGPSSwitchKey];
}

- (void)saveMockCoordinate:(CLLocationCoordinate2D)coordinate{
    NSDictionary *dic = @{
                          @"longitude":@(coordinate.longitude),
                          @"latitude":@(coordinate.latitude)
                          };
    [_defaults setObject:dic forKey:kZooMockCoordinateKey];
    [_defaults synchronize];
}

- (CLLocationCoordinate2D)mockCoordinate{
    NSDictionary *dic = [_defaults valueForKey:kZooMockCoordinateKey];
    CLLocationCoordinate2D coordinate ;
    if (dic[@"longitude"]) {
        coordinate.longitude = [dic[@"longitude"] doubleValue];
    }else{
        coordinate.longitude = 0.;
    }
    if (dic[@"latitude"]) {
        coordinate.latitude = [dic[@"latitude"] doubleValue];
    }else{
        coordinate.latitude = 0.;
    }
    
    return coordinate;
}

- (void)saveFpsSwitch:(BOOL)on{
    [_defaults setBool:on forKey:kZooFpsKey];
    [_defaults synchronize];
}

- (BOOL)fpsSwitch{
    return [_defaults boolForKey:kZooFpsKey];
}

- (void)saveCpuSwitch:(BOOL)on{
    [_defaults setBool:on forKey:kZooCpuKey];
    [_defaults synchronize];
}

- (BOOL)cpuSwitch{
    return [_defaults boolForKey:kZooCpuKey];
}

- (void)saveMemorySwitch:(BOOL)on{
    [_defaults setBool:on forKey:kZooMemoryKey];
    [_defaults synchronize];
}

- (BOOL)memorySwitch{
    return [_defaults boolForKey:kZooMemoryKey];
}

- (void)saveNetFlowSwitch:(BOOL)on{
    [_defaults setBool:on forKey:kZooNetFlowKey];
    [_defaults synchronize];
}

- (BOOL)netFlowSwitch{
    return [_defaults boolForKey:kZooNetFlowKey];
}

- (void)saveAllTestSwitch:(BOOL)on{
    [_defaults setBool:on forKey:kZooAllTestKey];
    [_defaults synchronize];
}

- (BOOL)allTestSwitch{
    return [_defaults boolForKey:kZooAllTestKey];
}

- (void)saveLargeImageDetectionSwitch:(BOOL)on{
    [_defaults setBool:on forKey:kZooLargeImageDetectionKey];
    [_defaults synchronize];
}

- (BOOL)largeImageDetectionSwitch{
    return [_defaults boolForKey: kZooLargeImageDetectionKey];
}

- (void)saveSubThreadUICheckSwitch:(BOOL)on{
    [_defaults setBool:on forKey:kZooSubThreadUICheckKey];
    [_defaults synchronize];
}

- (BOOL)subThreadUICheckSwitch{
    return [_defaults boolForKey:kZooSubThreadUICheckKey];
}

- (void)saveMethodUseTimeSwitch:(BOOL)on{
    [_defaults setBool:on forKey:kZooMethodUseTimeKey];
    [_defaults synchronize];
}

- (BOOL)methodUseTimeSwitch{
    return [_defaults boolForKey:kZooMethodUseTimeKey];
}

- (void)saveStartTimeSwitch:(BOOL)on {
    [_defaults setBool:on forKey:kZooStartTimeKey];
    [_defaults synchronize];
}

- (BOOL)startTimeSwitch{
    return [_defaults boolForKey:kZooStartTimeKey];
}

- (void)saveANRTrackSwitch:(BOOL)on {
    [_defaults setBool:on forKey:kZooANRTrackKey];
    [_defaults synchronize];
}

- (BOOL)anrTrackSwitch {
    return [_defaults boolForKey:kZooANRTrackKey];
}

- (void)saveStartClass : (NSString *)startClass {
    [_defaults setObject:startClass forKey:kZooStartClassKey];
    [_defaults synchronize];
}

- (NSString *)startClass {
    NSString *startClass = [_defaults objectForKey:kZooStartClassKey];
    return startClass;
}

// 内存泄漏开关
- (void)saveMemoryLeak:(BOOL)on{
    [_defaults setBool:on forKey:kZooMemoryLeakKey];
    [_defaults synchronize];
}
- (BOOL)memoryLeak{
    if (_firstReadMemoryLeakOn) {
        return _memoryLeakOn;
    }
    _firstReadMemoryLeakOn = YES;
    _memoryLeakOn = [_defaults boolForKey:kZooMemoryLeakKey];
     
    return _memoryLeakOn;
}

// 内存泄漏弹框开关
- (void)saveMemoryLeakAlert:(BOOL)on{
    [_defaults setBool:on forKey:kZooMemoryLeakAlertKey];
    [_defaults synchronize];
}
- (BOOL)memoryLeakAlert{
    return [_defaults boolForKey:kZooMemoryLeakAlertKey];
}

// mockapi本地缓存情况
- (void)saveMockCache:(NSArray *)mocks{
    [_defaults setObject:mocks forKey:kZooMockCacheKey];
    [_defaults synchronize];
}
- (NSArray *)mockCahce{
    return [_defaults objectForKey:kZooMockCacheKey];
}

// 健康体检开关
- (void)saveHealthStart:(BOOL)on{
    [_defaults setBool:on forKey:kZooHealthStartKey];
    [_defaults synchronize];
}
- (BOOL)healthStart{
    return [_defaults boolForKey:kZooHealthStartKey];
}

// Kit Manager数据保存 只保存内部数据
- (void)saveKitManagerData:(NSArray *)dataArray{
    NSMutableArray *mutableDataArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in dataArray) {
        NSString *moduleName = dic[@"moduleName"];
        if (moduleName && ([moduleName isEqualToString:ZooLocalizedString(@"General")])) {
            NSArray *pluginArray = dic[@"pluginArray"];
            NSMutableArray *mutablepluginArray = [[NSMutableArray alloc] init];
            for (NSDictionary *subDic in pluginArray){
                [mutablepluginArray addObject:subDic.mutableCopy];
            }
            NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
            [mutableDic setValue:dic[@"moduleName"] forKey:@"moduleName"];
            [mutableDic setValue:mutablepluginArray forKey:@"pluginArray"];
            
            [mutableDataArray addObject:mutableDic];
        }

    }
    [_defaults setObject:mutableDataArray forKey:kZooManagerKey];
    [_defaults synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:ZooManagerUpdateNotification object:nil userInfo:nil];
}

- (NSMutableArray *)kitManagerData{
    //NSUserDefaults返回的对象都是不可变的,第一步要不他们都要变成可变的
    NSArray *dataArray = [_defaults objectForKey:kZooManagerKey];
    NSMutableArray *mutableDataArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in dataArray) {
        NSArray *pluginArray = dic[@"pluginArray"];
        NSMutableArray *mutablepluginArray = [[NSMutableArray alloc] init];
        for (NSDictionary *subDic in pluginArray){
            [mutablepluginArray addObject:subDic.mutableCopy];
        }
        NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
        [mutableDic setValue:dic[@"moduleName"] forKey:@"moduleName"];
        [mutableDic setValue:mutablepluginArray forKey:@"pluginArray"];
        
        [mutableDataArray addObject:mutableDic];
    }
    return mutableDataArray;
}

- (NSMutableArray *)kitShowManagerData{
    //NSUserDefaults返回的对象都是不可变的,第一步要不他们都要变成可变的
    NSArray *dataArray = [_defaults objectForKey:kZooManagerKey];
    NSMutableArray *mutableDataArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in dataArray) {
        NSArray *pluginArray = dic[@"pluginArray"];
        NSMutableArray *mutablepluginArray = [[NSMutableArray alloc] init];
        for (NSDictionary *subDic in pluginArray){
            BOOL show = [subDic[@"show"] boolValue];
            if (show) {
                [mutablepluginArray addObject:subDic.mutableCopy];
            }
        }
        NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
        [mutableDic setValue:dic[@"moduleName"] forKey:@"moduleName"];
        [mutableDic setValue:mutablepluginArray forKey:@"pluginArray"];
        
        [mutableDataArray addObject:mutableDic];
    }
    return mutableDataArray;
}

//外部数据+保存数据
- (NSMutableArray *)allKitShowManagerData{
     NSMutableArray *dataArray = [ZooManager shareInstance].dataArray;
    NSMutableArray *mutableDataArray = [[NSMutableArray alloc] init];
    if ([self kitShowManagerData].count>0) {
        for (NSDictionary *dic in dataArray) {
            NSString *moduleName = dic[@"moduleName"];
            if (moduleName && ([moduleName isEqualToString:ZooLocalizedString(@"General")])) {
                continue;
            }
            
            NSArray *pluginArray = dic[@"pluginArray"];
            NSMutableArray *mutablepluginArray = [[NSMutableArray alloc] init];
            for (NSDictionary *subDic in pluginArray){
                [mutablepluginArray addObject:subDic.mutableCopy];
            }
            NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
            [mutableDic setValue:dic[@"moduleName"] forKey:@"moduleName"];
            [mutableDic setValue:mutablepluginArray forKey:@"pluginArray"];
            
            [mutableDataArray addObject:mutableDic];

        }
        [mutableDataArray addObjectsFromArray:[self kitShowManagerData]];
    }else{
        NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
        for (NSDictionary *dic in dataArray) {
            NSString *moduleName = dic[@"moduleName"];
            if (moduleName && ([moduleName isEqualToString:ZooLocalizedString(@"General")])) {
                [mutableDataArray addObject:dic];
                continue;
            }
            
            NSArray *pluginArray = dic[@"pluginArray"];
            NSMutableArray *mutablepluginArray = [[NSMutableArray alloc] init];
            for (NSDictionary *subDic in pluginArray){
                [mutablepluginArray addObject:subDic.mutableCopy];
            }
            [mutableDic setValue:dic[@"moduleName"] forKey:@"moduleName"];
            [mutableDic setValue:mutablepluginArray forKey:@"pluginArray"];
        }
        if (mutableDic.allKeys.count) {
            [mutableDataArray insertObject:mutableDic atIndex:0];
        }
    }
    
    return mutableDataArray;
}

@end
