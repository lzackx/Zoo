//
//  ZooHealthManager.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ZooNetFlowHttpModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZooHealthManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, assign) BOOL start;

- (void)rebootAppForHealthCheck;

- (void)startHealthCheck;

- (void)stopHealthCheck;

- (void)startEnterPage:(Class)vcClass;

- (void)enterPage:(Class)vcClass;

- (void)leavePage:(Class)vcClass;

- (void)addHttpModel:(ZooNetFlowHttpModel *)httpModel;

- (void)addANRInfo:(NSDictionary *)anrInfo;

- (void)addSubThreadUI:(NSDictionary *)info;

- (void)addUILevel:(NSDictionary *)info;

- (void)addLeak:(NSDictionary *)info;

- (void)openH5Page:(NSString *)h5Url;

//检测结果
@property (nonatomic, assign) CGFloat startTime;//本次启动时间 单位ms
@property (nonatomic, copy) NSString *costDetail;//启动流程耗时详情


- (BOOL)blackList:(Class)vcClass;

@end

NS_ASSUME_NONNULL_END
