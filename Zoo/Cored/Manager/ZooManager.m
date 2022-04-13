//
//  ZooManager.m
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//
#import <UIKit/UIKit.h>
#import "ZooManager.h"
#import "ZooEntryWindow.h"
#import "ZooCacheManager.h"
#import "ZooStartPluginProtocol.h"
#import "ZooDefine.h"
#import "ZooUtil.h"
#import "ZooHomeWindow.h"
#import "Zooi18NUtil.h"
#import "ZooCrashUncaughtExceptionHandler.h"
#import "ZooCrashSignalExceptionHandler.h"
#import "ZooNSLogManager.h"
#import "ZooNSLogViewController.h"
#import "ZooNSLogListViewController.h"
#import "ZooHomeWindow.h"
#import "ZooANRManager.h"
#import "ZooLargeImageDetectionManager.h"
#import "ZooNetFlowOscillogramWindow.h"
#import "ZooNetFlowManager.h"
#import "ZooHealthManager.h"

#if ZooWithGPS
#import "ZooGPSMocker.h"
#endif


#if ZooWithLogger
#import "ZooCocoaLumberjackLogger.h"
#import "ZooCocoaLumberjackViewController.h"
#import "ZooCocoaLumberjackListViewController.h"
#endif


#define kTitle        @"title"
#define kDesc         @"desc"
#define kIcon         @"icon"
#define kPluginName   @"pluginName"
#define kAtModule     @"atModule"
#define kBuriedPoint  @"buriedPoint"

@implementation ZooManagerPluginTypeModel

@end

typedef void (^ZooANRBlock)(NSDictionary *);
typedef void (^ZooPerformanceBlock)(NSDictionary *);

@interface ZooManager()

@property (nonatomic, strong) ZooEntryWindow *entryWindow;

@property (nonatomic, strong) NSMutableArray *startPlugins;

@property (nonatomic, copy) ZooANRBlock anrBlock;

@property (nonatomic, copy) ZooPerformanceBlock performanceBlock;

@property (nonatomic, assign) BOOL hasInstall;

// 定制位置
@property (nonatomic) CGPoint startingPosition;

@end

@implementation ZooManager

+ (nonnull ZooManager *)shareInstance{
    static dispatch_once_t once;
    static ZooManager *instance;
    dispatch_once(&once, ^{
        instance = [[ZooManager alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _autoDock = YES;
        _keyBlockDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)install{
    //启用默认位置
    CGPoint defaultPosition = ZooStartingPosition;
    CGSize size = [UIScreen mainScreen].bounds.size;
    if (size.width > size.height) {
        defaultPosition = ZooFullScreenStartingPosition;
    }
    [self installWithStartingPosition:defaultPosition];
}

- (void)installWithMockDomain:(NSString *)mockDomain{
    self.mockDomain = mockDomain;
    [self install];
}

- (void)installWithStartingPosition:(CGPoint) position{
    _startingPosition = position;
    [self installWithCustomBlock:^{
        //什么也没发生
    }];
}

- (void)installWithCustomBlock:(void(^)(void))customBlock{
    //保证install只执行一次
    if (_hasInstall) {
        return;
    }
    _hasInstall = YES;
    for (int i=0; i<_startPlugins.count; i++) {
        NSString *pluginName = _startPlugins[i];
        Class pluginClass = NSClassFromString(pluginName);
        id<ZooStartPluginProtocol> plugin = [[pluginClass alloc] init];
        if (plugin) {
            [plugin startPluginDidLoad];
        }
    }
    
    customBlock();

    [self initEntry:self.startingPosition];
    
    //根据开关判断是否收集Crash日志
    if ([[ZooCacheManager sharedInstance] crashSwitch]) {
        [ZooCrashUncaughtExceptionHandler registerHandler];
        [ZooCrashSignalExceptionHandler registerHandler];
    }
    //根据开关判断是否开启流量监控
    if ([[ZooCacheManager sharedInstance] netFlowSwitch]) {
        [[ZooNetFlowManager shareInstance] canInterceptNetFlow:YES];
        //[[ZooNetFlowOscillogramWindow shareInstance] show];
    }

    //重新启动的时候，把帧率、CPU、内存和流量监控关闭
    [[ZooCacheManager sharedInstance] saveFpsSwitch:NO];
    [[ZooCacheManager sharedInstance] saveCpuSwitch:NO];
    [[ZooCacheManager sharedInstance] saveMemorySwitch:NO];

#if ZooWithGPS
    //开启mockGPS功能
    if ([[ZooCacheManager sharedInstance] mockGPSSwitch]) {
        CLLocationCoordinate2D coordinate = [[ZooCacheManager sharedInstance] mockCoordinate];
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        [[ZooGPSMocker shareInstance] mockPoint:loc];
    }
#endif

    
    //开启NSLog监控功能
    if ([[ZooCacheManager sharedInstance] nsLogSwitch]) {
        [[ZooNSLogManager sharedInstance] startNSLogMonitor];
    }
    
#if ZooWithLogger
    //开启CocoaLumberjack监控
    if ([[ZooCacheManager sharedInstance] loggerSwitch]) {
        [[ZooCocoaLumberjackLogger sharedInstance] startMonitor];
    }
#endif
    
    [[ZooANRManager sharedInstance] addANRBlock:^(NSDictionary *anrInfo) {
        if (self.anrBlock) {
            self.anrBlock(anrInfo);
        }
    }];
    
    //外部设置大图检测的数值
    if (_bigImageDetectionSize > 0){
        [ZooLargeImageDetectionManager shareInstance].minimumDetectionSize = _bigImageDetectionSize;
    }
    
    //拉取最新的mock数据
//    [[ZooMockManager sharedInstance] queryMockData:^(int flag) {
//        ZooLog(@"mock get data, flag == %i",flag);
//    }];
    
    //开启健康体检
    if ([[ZooCacheManager sharedInstance] healthStart]) {
        [[ZooHealthManager sharedInstance] startHealthCheck];
    }
    
}

#pragma mark - 常用工具
- (void)addGeneralPlugins {
    [self addPluginWithPluginType:ZooManagerPluginType_ZooAppSettingPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooAppInfoPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooSandboxPlugin];
#if ZooWithGPS
    [self addPluginWithPluginType:ZooManagerPluginType_ZooGPSPlugin];
#endif
    
    [self addPluginWithPluginType:ZooManagerPluginType_ZooH5Plugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooDeleteLocalDataPlugin];
    
    [self addPluginWithPluginType:ZooManagerPluginType_ZooNSLogPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooNSUserDefaultsPlugin];
#if ZooWithLogger
    [self addPluginWithPluginType:ZooManagerPluginType_ZooCocoaLumberjackPlugin];
#endif
    
#if ZooWithDatabase
    [self addPluginWithPluginType:ZooManagerPluginType_ZooDatabasePlugin];
#endif
    
}

#pragma mark - 性能检测
- (void)addPerformancePlugins {
    [self addPluginWithPluginType:ZooManagerPluginType_ZooFPSPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooCPUPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooMemoryPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooNetFlowPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooCrashPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooSubThreadUICheckPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooANRPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooLargeImageFilter];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooWeakNetworkPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooStartTimePlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooUIProfilePlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooTimeProfilePlugin];
#if ZooWithLoad
    [self addPluginWithPluginType:ZooManagerPluginType_ZooMethodUseTimePlugin];
#endif
#if ZooWithMLeaksFinder
    [self addPluginWithPluginType:ZooManagerPluginType_ZooMemoryLeakPlugin];
#endif
    
}

- (void)addUIPlugins {
    #pragma mark - 视觉工具
    [self addPluginWithPluginType:ZooManagerPluginType_ZooColorPickPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooViewCheckPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooViewAlignPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooViewMetricsPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooHierarchyPlugin];
}


/**
 初始化工具入口
 */
- (void)initEntry:(CGPoint) startingPosition{
    _entryWindow = [[ZooEntryWindow alloc] initWithStartPoint:startingPosition];
    [_entryWindow show];
    if(_autoDock){
        [_entryWindow setAutoDock:YES];
    }
}

- (void)addStartPlugin:(NSString *)pluginName{
    if (!_startPlugins) {
        _startPlugins = [[NSMutableArray alloc] init];
    }
    [_startPlugins addObject:pluginName];
}

- (void)addPluginWithPluginType:(ZooManagerPluginType)pluginType
{
    ZooManagerPluginTypeModel *model = [self getDefaultPluginDataWithPluginType:pluginType];
    [self addPluginWithTitle:model.title icon:model.icon desc:model.desc pluginName:model.pluginName atModule:model.atModule buriedPoint:model.buriedPoint];
}

// out 1
- (void)addPluginWithTitle:(NSString *)title icon:(NSString *)iconName desc:(NSString *)desc pluginName:(NSString *)entryName atModule:(NSString *)moduleName{
    [self addPluginWithTitle:title icon:iconName desc:desc pluginName:entryName atModule:moduleName buriedPoint:@"zoo_sdk_business_ck"];
}

- (void)addPluginWithTitle:(NSString *)title icon:(NSString *)iconName desc:(NSString *)desc pluginName:(NSString *)entryName atModule:(NSString *)moduleName buriedPoint:(NSString *)buriedPoint{
    
    NSMutableDictionary *pluginDic = [self foundGroupWithModule:moduleName];
    pluginDic[@"key"] = [NSString stringWithFormat:@"%@-%@-%@-%@",moduleName,title,iconName,desc];
    pluginDic[@"name"] = title;
    pluginDic[@"icon"] = iconName;
    pluginDic[@"desc"] = desc;
    pluginDic[@"pluginName"] = entryName;
    pluginDic[@"buriedPoint"] = buriedPoint;
    pluginDic[@"show"] = @1;
}

// out 2
- (void)addPluginWithTitle:(NSString *)title icon:(NSString *)iconName desc:(NSString *)desc pluginName:(NSString *)entryName atModule:(NSString *)moduleName handle:(void (^)(NSDictionary *))handleBlock
{
    NSMutableDictionary *pluginDic = [self foundGroupWithModule:moduleName];
    pluginDic[@"key"] = [NSString stringWithFormat:@"%@-%@-%@-%@",moduleName,title,iconName,desc];
    pluginDic[@"name"] = title;
    pluginDic[@"icon"] = iconName;
    pluginDic[@"desc"] = desc;
    pluginDic[@"pluginName"] = entryName;
    [_keyBlockDic setValue:[handleBlock copy] forKey:pluginDic[@"key"]];
    pluginDic[@"buriedPoint"] = @"zoo_sdk_business_ck";
    pluginDic[@"show"] = @1;

}

- (void)addPluginWithTitle:(NSString *)title image:(UIImage *)image desc:(NSString *)desc pluginName:(NSString *)entryName atModule:(NSString *)moduleName handle:(void (^)(NSDictionary * _Nonnull))handleBlock {
    NSMutableDictionary *pluginDic = [self foundGroupWithModule:moduleName];
    pluginDic[@"key"] = [NSString stringWithFormat:@"%@-%@-%@",moduleName,title,desc];
    pluginDic[@"name"] = title;
    pluginDic[@"image"] = image;
    pluginDic[@"desc"] = desc;
    pluginDic[@"pluginName"] = entryName;
    if (handleBlock) {
        [_keyBlockDic setValue:[handleBlock copy] forKey:pluginDic[@"key"]];
    }
    pluginDic[@"buriedPoint"] = @"zoo_sdk_business_ck";
    pluginDic[@"show"] = @1;
}

- (NSMutableDictionary *)foundGroupWithModule:(NSString *)module
{
    NSMutableDictionary *pluginDic = [NSMutableDictionary dictionary];
    pluginDic[@"moduleName"] = module;
    __block BOOL hasModule = NO;
    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *moduleDic = obj;
        NSString *moduleName = moduleDic[@"moduleName"];
        if ([moduleName isEqualToString:module]) {
            hasModule = YES;
            NSMutableArray *pluginArray = moduleDic[@"pluginArray"];
            if (pluginArray) {
                [pluginArray addObject:pluginDic];
            }
            [moduleDic setValue:pluginArray forKey:@"pluginArray"];
            *stop = YES;
        }
    }];
    if (!hasModule) {
        NSMutableArray *pluginArray = [[NSMutableArray alloc] initWithObjects:pluginDic, nil];
        [self registerPluginArray:pluginArray withModule:module];
    }
    return pluginDic;
}
- (void)removePluginWithPluginType:(ZooManagerPluginType)pluginType
{
    ZooManagerPluginTypeModel *model = [self getDefaultPluginDataWithPluginType:pluginType];
    [self removePluginWithPluginName:model.pluginName atModule:model.atModule];
}

- (void)removePluginWithPluginName:(NSString *)pluginName atModule:(NSString *)moduleName{
    [self unregisterPlugin:pluginName withModule:moduleName];
}

- (void)registerPluginArray:(NSMutableArray*)array withModule:(NSString*)moduleName{
    if (!_dataArray){
        _dataArray = [[NSMutableArray alloc]init];
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:moduleName forKey:@"moduleName"];
    [dic setValue:array forKey:@"pluginArray"];
    [_dataArray addObject:dic];
}

- (void)unregisterPlugin:(NSString*)pluginName withModule:(NSString*)moduleName{
    if (!_dataArray){
        return;
    }
    id object;
    for (object in _dataArray) {
        NSString *tempModuleName = [((NSMutableDictionary *)object) valueForKey:@"moduleName"];
        if ([tempModuleName isEqualToString:moduleName]) {
            NSMutableArray *tempPluginArray = [((NSMutableDictionary *)object) valueForKey:@"pluginArray"];
            id pluginObject;
            for (pluginObject in tempPluginArray) {
                NSString *tempPluginName = [((NSMutableDictionary *)pluginObject) valueForKey:@"pluginName"];
                if ([tempPluginName isEqualToString:pluginName]) {
                    [tempPluginArray removeObject:pluginObject];
                    return;
                }
            }
        }
    }
}

- (BOOL)isShowZoo{
    if (!_entryWindow) {
        return NO;
    }
    return !_entryWindow.hidden;
}

- (void)showZoo{
    if (_entryWindow.hidden) {
        _entryWindow.hidden = NO;
    }
}

- (void)hiddenZoo{
    if (!_entryWindow.hidden) {
        _entryWindow.hidden = YES;
     }
}


- (void)addH5DoorBlock:(void(^)(NSString *h5Url))block{
    self.h5DoorBlock = block;
}

- (void)addANRBlock:(void(^)(NSDictionary *anrDic))block{
    self.anrBlock = block;
}

- (void)addPerformanceBlock:(void(^)(NSDictionary *performanceDic))block{
    self.performanceBlock = block;
}

- (void)addWebpHandleBlock:(UIImage *(^)(NSString *filePath))block{
    self.webpHandleBlock = block;
}

- (void)hiddenHomeWindow{
    [[ZooHomeWindow shareInstance] hide];
}

#pragma mark - default data
- (ZooManagerPluginTypeModel *)getDefaultPluginDataWithPluginType:(ZooManagerPluginType)pluginType
{
    NSArray *dataArray = @{
                           @(ZooManagerPluginType_ZooAppSettingPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"应用设置")},
                                   @{kDesc:ZooLocalizedString(@"应用设置")},
                                   @{kIcon:@"zoo_setting"},
                                   @{kPluginName:@"ZooAppSettingPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"常用工具")},
                                   @{kBuriedPoint:@"zoo_sdk_comm_ck_setting"}
                                    ],
                           @(ZooManagerPluginType_ZooAppInfoPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"App信息")},
                                   @{kDesc:ZooLocalizedString(@"App信息")},
                                   @{kIcon:@"zoo_app_info"},
                                   @{kPluginName:@"ZooAppInfoPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"常用工具")},
                                   @{kBuriedPoint:@"zoo_sdk_comm_ck_appinfo"}
                                   ],
                           @(ZooManagerPluginType_ZooSandboxPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"沙盒浏览器")},
                                   @{kDesc:ZooLocalizedString(@"沙盒浏览器")},
                                   @{kIcon:@"zoo_file"},
                                   @{kPluginName:@"ZooSandboxPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"常用工具")},
                                   @{kBuriedPoint:@"zoo_sdk_comm_ck_sandbox"}
                                   ],
                           @(ZooManagerPluginType_ZooGPSPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"Mock GPS")},
                                   @{kDesc:ZooLocalizedString(@"Mock GPS")},
                                   @{kIcon:@"zoo_mock_gps"},
                                   @{kPluginName:@"ZooGPSPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"常用工具")},
                                   @{kBuriedPoint:@"zoo_sdk_comm_ck_gps"}
                                   ],
                           @(ZooManagerPluginType_ZooH5Plugin) : @[
                                   @{kTitle:ZooLocalizedString(@"H5任意门")},
                                   @{kDesc:ZooLocalizedString(@"H5任意门")},
                                   @{kIcon:@"zoo_h5"},
                                   @{kPluginName:@"ZooH5Plugin"},
                                   @{kAtModule:ZooLocalizedString(@"常用工具")},
                                   @{kBuriedPoint:@"zoo_sdk_comm_ck_h5"}
                                   ],
                           @(ZooManagerPluginType_ZooDeleteLocalDataPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"清理缓存")},
                                   @{kDesc:ZooLocalizedString(@"清理缓存")},
                                   @{kIcon:@"zoo_qingchu"},
                                   @{kPluginName:@"ZooDeleteLocalDataPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"常用工具")},
                                   @{kBuriedPoint:@"zoo_sdk_comm_ck_cache"}
                                   ],
                           @(ZooManagerPluginType_ZooNSLogPlugin) : @[
                                   @{kTitle:@"NSLog"},
                                   @{kDesc:@"NSLog"},
                                   @{kIcon:@"zoo_nslog"},
                                   @{kPluginName:@"ZooNSLogPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"常用工具")},
                                   @{kBuriedPoint:@"zoo_sdk_comm_ck_log"}
                                   ],
                           @(ZooManagerPluginType_ZooCocoaLumberjackPlugin) : @[
                                   @{kTitle:@"Lumberjack"},
                                   @{kDesc:ZooLocalizedString(@"Lumberjack")},
                                   @{kIcon:@"zoo_log"},
                                   @{kPluginName:@"ZooCocoaLumberjackPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"常用工具")},
                                   @{kBuriedPoint:@"zoo_sdk_comm_ck_lumberjack"}
                                   ],
                           @(ZooManagerPluginType_ZooDatabasePlugin) : @[
                                   @{kTitle:@"DBView"},
                                   @{kDesc:ZooLocalizedString(@"数据库预览")},
                                   @{kIcon:@"zoo_database"},
                                   @{kPluginName:@"ZooDatabasePlugin"},
                                   @{kAtModule:ZooLocalizedString(@"常用工具")},
                                   @{kBuriedPoint:@"zoo_sdk_comm_ck_dbview"}
                                   ],
                           @(ZooManagerPluginType_ZooNSUserDefaultsPlugin) : @[
                                   @{kTitle:@"UserDefaults"},
                                   @{kDesc:@"UserDefaults"},
                                   @{kIcon:@"zoo_database"},
                                   @{kPluginName:@"ZooNSUserDefaultsPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"常用工具")},
                                   @{kBuriedPoint:@"zoo_sdk_comm_ck_userdefault"}
                           ],
                           
                           // 性能检测
                           @(ZooManagerPluginType_ZooFPSPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"帧率")},
                                   @{kDesc:ZooLocalizedString(@"帧率")},
                                   @{kIcon:@"zoo_fps"},
                                   @{kPluginName:@"ZooFPSPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")},
                                   @{kBuriedPoint:@"zoo_sdk_performance_ck_fps"}
                                   ],
                           @(ZooManagerPluginType_ZooCPUPlugin) : @[
                                   @{kTitle:@"CPU"},
                                   @{kDesc:ZooLocalizedString(@"CPU")},
                                   @{kIcon:@"zoo_cpu"},
                                   @{kPluginName:@"ZooCPUPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")},
                                   @{kBuriedPoint:@"zoo_sdk_performance_ck_cpu"}
                                   ],
                           @(ZooManagerPluginType_ZooMemoryPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"内存")},
                                   @{kDesc:ZooLocalizedString(@"内存")},
                                   @{kIcon:@"zoo_memory"},
                                   @{kPluginName:@"ZooMemoryPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")},
                                   @{kBuriedPoint:@"zoo_sdk_performance_ck_arm"}
                                   ],
                           @(ZooManagerPluginType_ZooNetFlowPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"网络")},
                                   @{kDesc:ZooLocalizedString(@"网络监控")},
                                   @{kIcon:@"zoo_net"},
                                   @{kPluginName:@"ZooNetFlowPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")},
                                   @{kBuriedPoint:@"zoo_sdk_performance_ck_network"}
                                   ],
                           @(ZooManagerPluginType_ZooCrashPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"Crash")},
                                   @{kDesc:ZooLocalizedString(@"Crash")},
                                   @{kIcon:@"zoo_crash"},
                                   @{kPluginName:@"ZooCrashPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")},
                                   @{kBuriedPoint:@"zoo_sdk_comm_ck_crash"}
                                   ],
                           @(ZooManagerPluginType_ZooSubThreadUICheckPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"子线程UI")},
                                   @{kDesc:ZooLocalizedString(@"子线程UI")},
                                   @{kIcon:@"zoo_ui"},
                                   @{kPluginName:@"ZooSubThreadUICheckPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")},
                                   @{kBuriedPoint:@"zoo_sdk_comm_ck_child_thread"}
                                   ],
                           @(ZooManagerPluginType_ZooANRPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"卡顿")},
                                   @{kDesc:ZooLocalizedString(@"卡顿")},
                                   @{kIcon:@"zoo_kadun"},
                                   @{kPluginName:@"ZooANRPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")},
                                   @{kBuriedPoint:@"zoo_sdk_performance_ck_block"}
                                   ],
                           @(ZooManagerPluginType_ZooMethodUseTimePlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"Load耗时")},
                                   @{kDesc:ZooLocalizedString(@"Load耗时")},
                                   @{kIcon:@"zoo_method_use_time"},
                                   @{kPluginName:@"ZooMethodUseTimePlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")},
                                   @{kBuriedPoint:@"zoo_sdk_performance_ck_load"}
                                   ],
                           
                           @(ZooManagerPluginType_ZooLargeImageFilter) : @[
                                   @{kTitle:ZooLocalizedString(@"大图检测")},
                                   @{kDesc:ZooLocalizedString(@"大图检测")},
                                   @{kIcon:@"zoo_net"},
                                   @{kPluginName:@"ZooLargeImagePlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")},
                                   @{kBuriedPoint:@"zoo_sdk_performance_ck_img"}
                                   ],
                           @(ZooManagerPluginType_ZooStartTimePlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"启动耗时")},
                                   @{kDesc:ZooLocalizedString(@"启动耗时")},
                                   @{kIcon:@"zoo_app_start_time"},
                                   @{kPluginName:@"ZooStartTimePlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")},
                                   @{kBuriedPoint:@"zoo_sdk_performance_ck_appstart_coast"}
                                   ],
                           @(ZooManagerPluginType_ZooMemoryLeakPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"内存泄漏")},
                                   @{kDesc:ZooLocalizedString(@"内存泄漏统计")},
                                   @{kIcon:@"zoo_memory_leak"},
                                   @{kPluginName:@"ZooMLeaksFinderPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")},
                                   @{kBuriedPoint:@"zoo_sdk_performance_ck_leak"}
                                   ],
                           @(ZooManagerPluginType_ZooUIProfilePlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"UI层级")},
                                   @{kDesc:ZooLocalizedString(@"UI层级s")},
                                   @{kIcon:@"zoo_view_level"},
                                   @{kPluginName:@"ZooUIProfilePlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")},
                                   @{kBuriedPoint:@"zoo_sdk_ui_ck_hierarchy"}
                           ],
                           @(ZooManagerPluginType_ZooTimeProfilePlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"函数耗时")},
                                   @{kDesc:ZooLocalizedString(@"函数耗时统计")},
                                   @{kIcon:@"zoo_time_profiler"},
                                   @{kPluginName:@"ZooTimeProfilerPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")},
                                   @{kBuriedPoint:@"zoo_sdk_performance_ck_method_coast"}
                           ],
                           @(ZooManagerPluginType_ZooWeakNetworkPlugin) : @[
                                     @{kTitle:ZooLocalizedString(@"模拟弱网")},
                                     @{kDesc:ZooLocalizedString(@"模拟弱网测试")},
                                     @{kIcon:@"zoo_weaknet"},
                                     @{kPluginName:@"ZooWeakNetworkPlugin"},
                                     @{kAtModule:ZooLocalizedString(@"性能检测")},
                                     @{kBuriedPoint:@"zoo_sdk_comm_ck_weaknetwork"}
                             ],
                           // 视觉工具
                           @(ZooManagerPluginType_ZooColorPickPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"取色器")},
                                   @{kDesc:ZooLocalizedString(@"取色器")},
                                   @{kIcon:@"zoo_straw"},
                                   @{kPluginName:@"ZooColorPickPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"视觉工具")},
                                   @{kBuriedPoint:@"zoo_sdk_ui_ck_color_pick"}
                                   ],
                           @(ZooManagerPluginType_ZooViewCheckPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"组件检查")},
                                   @{kDesc:ZooLocalizedString(@"组件检查")},
                                   @{kIcon:@"zoo_view_check"},
                                   @{kPluginName:@"ZooViewCheckPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"视觉工具")},
                                   @{kBuriedPoint:@"zoo_sdk_ui_ck_widget"}
                                   ],
                           @(ZooManagerPluginType_ZooViewAlignPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"对齐标尺")},
                                   @{kDesc:ZooLocalizedString(@"对齐标尺")},
                                   @{kIcon:@"zoo_align"},
                                   @{kPluginName:@"ZooViewAlignPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"视觉工具")},
                                   @{kBuriedPoint:@"zoo_sdk_ui_ck_aligin_scaleplate"}
                                   ],
                           @(ZooManagerPluginType_ZooViewMetricsPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"布局边框")},
                                   @{kDesc:ZooLocalizedString(@"布局边框")},
                                   @{kIcon:@"zoo_viewmetrics"},
                                   @{kPluginName:@"ZooViewMetricsPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"视觉工具")},
                                   @{kBuriedPoint:@"zoo_sdk_ui_ck_border"}
                                   ],
                          @(ZooManagerPluginType_ZooHierarchyPlugin) : @[
                                           @{kTitle:ZooLocalizedString(@"UI结构")},
                                           @{kDesc:ZooLocalizedString(@"显示UI结构")},
                                           @{kIcon:@"zoo_view_level"},
                                           @{kPluginName:@"ZooHierarchyPlugin"},
                                           @{kAtModule:ZooLocalizedString(@"视觉工具")},
                                           @{kBuriedPoint:@"zoo_sdk_ui_ck_widget_3d"}
                                   ],
                           }[@(pluginType)];
    
    ZooManagerPluginTypeModel *model = [ZooManagerPluginTypeModel new];
    model.title = dataArray[0][kTitle];
    model.desc = dataArray[1][kDesc];
    model.icon = dataArray[2][kIcon];
    model.pluginName = dataArray[3][kPluginName];
    model.atModule = dataArray[4][kAtModule];
    model.buriedPoint = dataArray[5][kBuriedPoint];
    
    return model;
}

- (void)setStartClass:(NSString *)startClass {
    [[ZooCacheManager sharedInstance] saveStartClass:startClass];
}

- (NSString *)startClass{
    return [[ZooCacheManager sharedInstance] startClass];
}

- (void)configEntryBtnBlingWithText:(NSString *)text backColor:(UIColor *)backColor {
    [self.entryWindow configEntryBtnBlingWithText:text backColor:backColor];
}

@end
