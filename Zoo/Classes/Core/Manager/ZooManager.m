//
//  ZooManager.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.
#import <UIKit/UIKit.h>
#import "ZooManager.h"
#import "ZooManager+Plugins.h"
#import "ZooEntryWindow.h"
#import "ZooCacheManager.h"
#import "ZooStartPluginProtocol.h"
#import "ZooDefine.h"
#import "ZooUtil.h"
#import "ZooHomeWindow.h"
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
    
    [self addCorePlugins];
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
    
    //开启健康体检
    if ([[ZooCacheManager sharedInstance] healthStart]) {
        [[ZooHealthManager sharedInstance] startHealthCheck];
    }
    
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

// out 1
- (void)addPluginWithTitle:(NSString *)title icon:(NSString *)iconName desc:(NSString *)desc pluginName:(NSString *)entryName atModule:(NSString *)moduleName{
    
    NSMutableDictionary *pluginDic = [self foundGroupWithModule:moduleName];
    pluginDic[@"key"] = [NSString stringWithFormat:@"%@-%@-%@-%@",moduleName,title,iconName,desc];
    pluginDic[@"name"] = title;
    pluginDic[@"icon"] = iconName;
    pluginDic[@"desc"] = desc;
    pluginDic[@"pluginName"] = entryName;
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

- (void)addURLRouterBlock:(void(^)(NSString *url))block{
    self.urlRouterBlock = block;
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
