//
//  ZooHealthManager.m
//  ZooKit
//
//  Created by lZackx on 04/12/2022
//

#import "ZooHealthManager.h"
#import "ZooFPSUtil.h"
#import "ZooCPUUtil.h"
#import "ZooMemoryUtil.h"
#import "ZooNetworkUtil.h"
#import "ZooUtil.h"
#import "ZooAppInfoUtil.h"
#import "ZooDefine.h"
#import "ZooManager.h"
#import "ZooCacheManager.h"
#import "ZooANRManager.h"
#import "UIViewController+Zoo.h"
#import "ZooUIProfileManager.h"
#import <UIKit/UIKit.h>
#import "ZooUtil.h"
#import "ZooHealthCountdownWindow.h"
#import "ZooBaseViewController.h"
#import "ZooToastUtil.h"

#if __has_include("ZooMethodUseTimeManager.h")
#import "ZooMethodUseTimeManager.h"
#endif



@interface ZooHealthManager()
//每秒运行一次
@property (nonatomic, strong) NSTimer *secondTimer;
@property (nonatomic, strong) ZooFPSUtil *fpsUtil;
@property (nonatomic, assign) BOOL firstEnter;

@property (nonatomic, strong) NSMutableArray *cpuPageArray;
@property (nonatomic, strong) NSMutableArray *cpuArray;
@property (nonatomic, strong) NSMutableArray *memoryPageArray;
@property (nonatomic, strong) NSMutableArray *memoryArray;
@property (nonatomic, strong) NSMutableArray *fpsPageArray;
@property (nonatomic, strong) NSMutableArray *fpsArray;
@property (nonatomic, strong) NSMutableArray *networkPageArray;
@property (nonatomic, strong) NSMutableArray *networkArray;
@property (nonatomic, strong) NSMutableArray *blockArray;
@property (nonatomic, strong) NSMutableArray *subThreadUIArray;
@property (nonatomic, strong) NSMutableArray *uiLevelArray;
@property (nonatomic, strong) NSMutableArray *leakArray;
@property (nonatomic, strong) NSMutableDictionary *pageEnterMap;
@property (nonatomic, strong) NSMutableArray *pageLoadArray;
@property (nonatomic, strong) NSMutableArray *bigFileArray;
@property (nonatomic, copy) NSString *h5UrlString;

@end

@implementation ZooHealthManager{
    dispatch_semaphore_t semaphore;
}

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _start = [[ZooCacheManager sharedInstance] healthStart];
        _cpuPageArray = [[NSMutableArray alloc] init];
        _cpuArray = [[NSMutableArray alloc] init];
        _memoryPageArray = [[NSMutableArray alloc] init];
        _memoryArray = [[NSMutableArray alloc] init];
        _fpsPageArray = [[NSMutableArray alloc] init];
        _fpsArray = [[NSMutableArray alloc] init];
        _networkPageArray = [[NSMutableArray alloc] init];
        _networkArray = [[NSMutableArray alloc] init];
        _blockArray = [[NSMutableArray alloc] init];
        _subThreadUIArray = [[NSMutableArray alloc] init];
        _uiLevelArray = [[NSMutableArray alloc] init];
        _leakArray = [[NSMutableArray alloc] init];
        _pageEnterMap = [[NSMutableDictionary alloc] init];
        _pageLoadArray = [[NSMutableArray alloc] init];
        _bigFileArray = [[NSMutableArray alloc] init];
        semaphore = dispatch_semaphore_create(1);
    }
    return self;
}

- (void)rebootAppForHealthCheck{
    [[ZooCacheManager sharedInstance] saveHealthStart:YES];
    [[ZooCacheManager sharedInstance] saveStartTimeSwitch:YES];
    #if __has_include("ZooMethodUseTimeManager.h")
    [ZooMethodUseTimeManager sharedInstance].on = YES;
    #endif
    [[ZooCacheManager sharedInstance] saveNetFlowSwitch:YES];
    [[ZooCacheManager sharedInstance] saveSubThreadUICheckSwitch:YES];
    [[ZooCacheManager sharedInstance] saveMemoryLeak:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        exit(0);
    });
    
}

- (void)startHealthCheck{
    _start = YES;
    if (_start) {
        if(!_secondTimer){
            _secondTimer = [NSTimer timerWithTimeInterval:0.5f target:self selector:@selector(doSecondFunction) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_secondTimer forMode:NSRunLoopCommonModes];
            if (!_fpsUtil) {
                _fpsUtil = [[ZooFPSUtil alloc] init];
                __weak typeof(self) weakSelf = self;
                [_fpsUtil addFPSBlock:^(NSInteger fps) {
                    [weakSelf handleFPS:fps];
                    
                }];
            }
            [_fpsUtil start];
        }
        [[ZooANRManager sharedInstance] start];
        [ZooUIProfileManager sharedInstance].enable = YES;
    }
}

- (void)stopHealthCheck{
    _start = NO;
    [[ZooHealthCountdownWindow shareInstance] hide];
    [[ZooCacheManager sharedInstance] saveHealthStart:NO];
    [[ZooCacheManager sharedInstance] saveStartTimeSwitch:NO];
    #if __has_include("ZooMethodUseTimeManager.h")
    [ZooMethodUseTimeManager sharedInstance].on = NO;
    #endif
    [[ZooCacheManager sharedInstance] saveNetFlowSwitch:NO];
    [[ZooCacheManager sharedInstance] saveSubThreadUICheckSwitch:NO];
    [[ZooCacheManager sharedInstance] saveMemoryLeak:NO];
    [ZooUIProfileManager sharedInstance].enable = NO;
    [[ZooANRManager sharedInstance] stop];
    if(_secondTimer){
        [_secondTimer invalidate];
        _secondTimer = nil;
    }
    if (_fpsUtil) {
        [_fpsUtil end];
    }
    [self upLoadData];
}

- (void)doSecondFunction{
    //最多采样40个点
    if(_cpuPageArray.count > 40){
        return;
    }
    
    //1、获取当前时间
    NSString *currentTimeInterval = [ZooUtil currentTimeInterval];
    
    //2、获取当前cpu占用率
    CGFloat cpuValue = -1;
    cpuValue = [ZooCPUUtil cpuUsageForApp];
    if (cpuValue * 100 > 100) {
        cpuValue = 100;
    }else{
        cpuValue = cpuValue * 100;
    }
    
    [_cpuPageArray addObject:@{
        @"time":currentTimeInterval,
        @"value":[NSString stringWithFormat:@"%f",cpuValue]//单位百分比
    }];
    
    //3、获取当前memoryValue使用量
    NSInteger memoryValue = [ZooMemoryUtil useMemoryForApp];//单位MB
    [_memoryPageArray addObject:@{
        @"time":currentTimeInterval,
        @"value":[NSString stringWithFormat:@"%zi",memoryValue]//单位MB
    }];
}

- (void)handleFPS:(NSInteger)fps{
    //最多采样40个点
    if (_fpsPageArray.count > 40) {
        return;
    }
    [_fpsPageArray addObject:@{
        @"time":[ZooUtil currentTimeInterval],
        @"value":[NSString stringWithFormat:@"%zi",fps]
    }];
}

- (void)upLoadData{
    if (self.caseName.length>0 && self.testPerson.length>0) {
        NSString *testTime = [ZooUtil dateFormatNow];
        NSString *phoneName = [ZooAppInfoUtil iphoneType];
        NSString *phoneSystem = [[UIDevice currentDevice] systemVersion];
        NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
        NSString *appName = [ZooAppInfoUtil appName];
        
        
        //启动流程
        NSArray *loadArray = nil;
        #if __has_include("ZooMethodUseTimeManager.h")
        loadArray = [[ZooMethodUseTimeManager sharedInstance] fixLoadModelArrayForHealth];
        #endif
        
        NSDictionary *appStart = @{
            @"costTime" : @(self.startTime),
            @"costDetail" : STRING_NOT_NULL(self.costDetail),
            @"loadFunc" : loadArray ? loadArray : @[]
        };
        
        //大文件扫描
        NSString *homeDir = NSHomeDirectory();
        ZooUtil *util = [[ZooUtil alloc] init];
        [util getBigSizeFileFormPath:homeDir];
        NSArray *bigFileInfoArray = [self formatInfoByPathArray:util.bigFileArray];
        
        NSDictionary *dic = @{
            @"baseInfo":@{
                    @"caseName":STRING_NOT_NULL(self.caseName),
                    @"testPerson":STRING_NOT_NULL(self.testPerson),
                    @"platform":@"iOS",
                    @"time":testTime,
                    @"phoneMode":phoneName,
                    @"systemVersion":phoneSystem,
                    @"appName":appName,
                    @"appVersion":appVersion,
                    @"dokitVersion":ZooVersion,
            },
            @"data":@{
                    @"cpu":[_cpuArray copy],
                    @"memory":[_memoryArray copy],
                    @"fps":[_fpsArray copy],
                    @"appStart":appStart,
                    @"network": [_networkArray copy],
                    @"block":[_blockArray copy],
                    @"subThreadUI":[_subThreadUIArray copy],
                    @"uiLevel":[_uiLevelArray copy],
                    @"leak":[_leakArray copy],
                    @"pageLoad":[_pageLoadArray copy],
                    @"bigFile":[bigFileInfoArray copy]
            }
        };
        
        ZooLog(@"upload info == %@",dic);

        [ZooNetworkUtil postWithUrlString:@"https://www.dokit.cn/healthCheck/addCheckData" params:dic success:^(NSDictionary * _Nonnull result) {
            NSInteger code = [result[@"code"] integerValue];
            if (code == 200) {
                [ZooToastUtil showToastBlack:ZooLocalizedString(@"数据上传成功")  inView:[UIViewController rootViewControllerForZooHomeWindow].view];
            }else{
                NSString *msg = result[@"msg"];
                if (msg) {
                    [ZooToastUtil showToastBlack:msg inView:[UIViewController rootViewControllerForZooHomeWindow].view];
                }
            }

        } error:^(NSError * _Nonnull error) {
            [ZooToastUtil showToastBlack:ZooLocalizedString(@"数据上传失败")  inView:[UIViewController rootViewControllerForZooHomeWindow].view];
        }];
    }
    
    [_cpuPageArray removeAllObjects];
    [_memoryPageArray removeAllObjects];
    [_fpsPageArray removeAllObjects];
    [_networkPageArray removeAllObjects];
    [_cpuArray removeAllObjects];
    [_memoryArray removeAllObjects];
    [_fpsArray removeAllObjects];
    [_networkArray removeAllObjects];
    [_blockArray removeAllObjects];
    [_subThreadUIArray removeAllObjects];
    [_uiLevelArray removeAllObjects];
    [_leakArray removeAllObjects];
    [_pageLoadArray removeAllObjects];
    [_bigFileArray removeAllObjects];
    _h5UrlString = nil;
}

- (void)startEnterPage:(Class)vcClass{
    if (!_start) {
        return;
    }
    if ([self blackList:vcClass]) {
        return;
    }
    NSString *pageName = NSStringFromClass(vcClass);
    CGFloat beginTime = CACurrentMediaTime();
    [_pageEnterMap setValue:@(beginTime) forKey:pageName];
    ZooLog(@"yixiang 开始进入页面 == %@ 时间 == %f",pageName,beginTime);
    
}

- (void)enterPage:(Class)vcClass{
    if (!_start) {
        return;
    }
    if ([self blackList:vcClass]) {
        return;
    }
    [[ZooHealthCountdownWindow shareInstance] start:10];
    NSString *pageName = NSStringFromClass(vcClass);
    ZooLog(@"yixiang 已经进入页面 == %@",pageName);
    if (_pageEnterMap[pageName]) {
        CGFloat beginTime = [_pageEnterMap[pageName] floatValue];
        CGFloat endTime = CACurrentMediaTime();
        NSInteger costTime = (NSInteger)((endTime - beginTime)*1000+0.5);//四舍五入 ms
        [_pageLoadArray addObject:@{
            @"page":NSStringFromClass(vcClass),
            @"time":@(costTime)//ms
        }];
    }
    [_pageEnterMap removeObjectForKey:pageName];
    [_cpuPageArray removeAllObjects];
    [_memoryPageArray removeAllObjects];
    [_fpsPageArray removeAllObjects];
    [_networkPageArray removeAllObjects];
}

- (void)leavePage:(Class)vcClass{
    if (!_start) {
        return;
    }
    if ([self blackList:vcClass]) {
        return;
    }
    NSString *pageName = NSStringFromClass(vcClass);
    if (_h5UrlString.length>0) {
        pageName = [NSString stringWithFormat:@"%@(%@)",pageName,_h5UrlString];
        _h5UrlString = nil;
    }
    
    ZooLog(@"离开页面 == %@",pageName);
    
    if (_networkPageArray.count>0) {
        [_networkArray addObject:@{
            @"page":pageName,
            @"values":[_networkPageArray copy]
        }];
    }
    
    //cpu 内存 fps必须保证每一个页面运行10秒
    if ([[ZooHealthCountdownWindow shareInstance] getCountdown] > 0) {
        return;
    }

    if (_cpuPageArray.count>0) {
        [_cpuArray addObject:@{
            @"page":pageName,
            @"values":[_cpuPageArray copy]
        }];
    }
    
    if(_memoryPageArray.count>0) {
        [_memoryArray addObject:@{
            @"page":pageName,
            @"values":[_memoryPageArray copy]
        }];
    }

    if (_fpsPageArray.count>0) {
        [_fpsArray addObject:@{
            @"page":pageName,
            @"values":[_fpsPageArray copy]
        }];
    }
    
    [[ZooHealthCountdownWindow shareInstance] hide];
}

- (BOOL)blackList:(Class)vcClass{
    if ([vcClass isSubclassOfClass:[ZooBaseViewController class]]) {
        return YES;
    }
    if ([vcClass isSubclassOfClass:[UINavigationController class]] || [vcClass isSubclassOfClass:[UITabBarController class]]) {
        return YES;
    }
    NSString *vcName = NSStringFromClass(vcClass);
    NSArray *blackList = @[
        @"UIViewController",
        @"UIInputWindowController",
        @"UICompatibilityInputViewController",
        @"UIEditingOverlayViewController",
        @"UISystemInputAssistantViewController",
        @"UIPredictionViewController",
        @"_UIRemoteInputViewController",
        @"UIEditingOverlayViewController",
        @"AssistiveTouchController",
        @"UICandidateViewController",
        @"UISystemKeyboardDockController",
        @"UIApplicationRotationFollowingControllerNoTouches"
    ];
    if ([blackList containsObject:vcName]) {
        return YES;
    }
    return NO;
}

- (void)addHttpModel:(ZooNetFlowHttpModel *)httpModel{
    if (_start) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [_networkPageArray addObject:@{
            @"time": [ZooUtil currentTimeInterval],
            @"url": STRING_NOT_NULL(httpModel.url) ,
            @"up": STRING_NOT_NULL(httpModel.uploadFlow),
            @"down": STRING_NOT_NULL(httpModel.downFlow),
            @"code": STRING_NOT_NULL(httpModel.statusCode),
            @"method": STRING_NOT_NULL(httpModel.method)
        }];
        dispatch_semaphore_signal(semaphore);
    }
}

- (void)addANRInfo:(NSDictionary *)anrInfo{
    if (_start) {
        [_blockArray addObject:@{
            @"page":[self currentTopVC],
            @"blockTime":anrInfo[@"duration"],
            @"detail":anrInfo[@"content"]
        }];
    }
}

- (void)addSubThreadUI:(NSDictionary *)info{
    if (_start) {
        [_subThreadUIArray addObject:@{
            @"page":[self currentTopVC],
            @"detail":info[@"content"]
        }];
    }
}

- (void)addUILevel:(NSDictionary *)info{
    if (_start) {
        [_uiLevelArray addObject:@{
            @"page":STRING_NOT_NULL([self currentTopVC]),
            @"level":info[@"level"],
            @"detail":info[@"detail"]
        }];
    }
}

- (void)addLeak:(NSDictionary *)info{
    if (_start) {
        NSString *viewStack = info[@"viewStack"];
        NSString *retainCycle = info[@"retainCycle"];
        NSString *detail = [NSString stringWithFormat:@"viewStack : \n%@ \n\n retainCycle : \n%@\n\n",STRING_NOT_NULL(viewStack),STRING_NOT_NULL(retainCycle)];
        [_leakArray addObject:@{
            @"page":info[@"className"],
            @"detail":detail
        }];
    }
}

- (void)openH5Page:(NSString *)h5Url{
    if (_start) {
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.h5UrlString = h5Url;
        });
    }
}



- (NSString *)currentTopVC{
    UIViewController *vc = [UIViewController topViewControllerForKeyWindow];
    NSString *vcName = NSStringFromClass([vc class]);
    return vcName;
}

- (NSArray *)formatInfoByPathArray:(NSArray *)pathArray{
    NSMutableArray *fileInfoArray = [[NSMutableArray alloc] init];
    for (NSString *path in pathArray) {
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        NSInteger fileSize = [dict[@"NSFileSize"] integerValue];
        //NSString *fileSizeString = [NSByteCountFormatter stringFromByteCount:fileSize countStyle: NSByteCountFormatterCountStyleFile];
        NSString *fileSizeString = [NSString stringWithFormat:@"%zi",fileSize];
        NSString *fileName = [path lastPathComponent];
        NSString *filePtahFromHomeDir = [self getPathFromHomeDir:path];
        [fileInfoArray addObject:@{
            @"fileName":fileName,
            @"fileSize":fileSizeString,
            @"filePath":filePtahFromHomeDir
        }];
    }
    return fileInfoArray;
}

- (NSString *)getPathFromHomeDir:(NSString *)path{
    NSString *homeDir = NSHomeDirectory();
    NSString *relativePath = @"";
    if ([path hasPrefix:homeDir]) {
        relativePath = [path substringFromIndex:homeDir.length];
    }
    return relativePath;
}
@end
