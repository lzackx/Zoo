//
//  ZooANRManager.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooANRManager.h"
#import "ZooCacheManager.h"
#import "ZooANRTracker.h"
#import "ZooMemoryUtil.h"
#import "ZooAppInfoUtil.h"
#import "Zooi18NUtil.h"
#import "ZooANRTool.h"
#import "ZooHealthManager.h"

//默认超时间隔
static CGFloat const kZooBlockMonitorTimeInterval = 0.2f;

@interface ZooANRManager()

@property (nonatomic, strong) ZooANRTracker *zooANRTracker;
@property (nonatomic, copy) ZooANRManagerBlock block;

@end

@implementation ZooANRManager

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _zooANRTracker = [[ZooANRTracker alloc] init];
        _timeOut = kZooBlockMonitorTimeInterval;
        _anrTrackOn = [ZooCacheManager sharedInstance].anrTrackSwitch;
        if (_anrTrackOn) {
            [self start];
        } else {
            [self stop];
            // 如果是关闭的话，删除上一次的卡顿记录
            NSFileManager *fm = [NSFileManager defaultManager];
            [fm removeItemAtPath:[ZooANRTool anrDirectory] error:nil];
        }
    }
    
    return self;
}

- (void)start {
    __weak typeof(self) weakSelf = self;
    [_zooANRTracker startWithThreshold:self.timeOut handler:^(NSDictionary *info) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf dumpWithInfo:info];
    }];
}

- (void)dumpWithInfo:(NSDictionary *)info {
    if (![info isKindOfClass:[NSDictionary class]]) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [[ZooHealthManager sharedInstance] addANRInfo:info];
        if (self.block) {
            self.block(info);
        }
        [ZooANRTool saveANRInfo:info];
    });

}

- (void)addANRBlock:(ZooANRManagerBlock)block{
    self.block = block;
}


- (void)dealloc {
    [self stop];
}

- (void)stop {
    [self.zooANRTracker stop];
}

- (void)setAnrTrackOn:(BOOL)anrTrackOn {
    _anrTrackOn = anrTrackOn;
    [[ZooCacheManager sharedInstance] saveANRTrackSwitch:anrTrackOn];
}

@end
