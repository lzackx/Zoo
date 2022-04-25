//
//  ZooManager+Plugins.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooManager+Plugins.h"
#import "Zooi18NUtil.h"


#define kTitle        @"title"
#define kDesc         @"desc"
#define kIcon         @"icon"
#define kPluginName   @"pluginName"
#define kAtModule     @"atModule"


@implementation ZooManager (Plugins)

#pragma mark - Platform
- (void)addPlatformPlugins {
#if ZooWithPlatform
    [self addPluginWithPluginType:ZooManagerPluginType_ZooHealthPlugin];
#endif
}

// MARK: - Logger
- (void)addLoggerPlugins {
#if ZooWithLogger
    [self addPluginWithPluginType:ZooManagerPluginType_ZooCocoaLumberjackPlugin];
#endif
}

// MARK: - MemoryLeak
- (void)addMemoryLeakPlugins {
#if ZooWithMLeaksFinder
    [self addPluginWithPluginType:ZooManagerPluginType_ZooMemoryLeakPlugin];
#endif
}

//#pragma mark - default data
//- (void)addPluginWithPluginType:(ZooManagerPluginType)pluginType {
//    ZooManagerPluginTypeModel *model = [self getDefaultPluginDataWithPluginType:pluginType];
//    [self addPluginWithTitle:model.title icon:model.icon desc:model.desc pluginName:model.pluginName atModule:model.atModule];
//}
//
//- (void)removePluginWithPluginType:(ZooManagerPluginType)pluginType {
//    ZooManagerPluginTypeModel *model = [self getDefaultPluginDataWithPluginType:pluginType];
//    [self removePluginWithPluginName:model.pluginName atModule:model.atModule];
//}
//
//- (ZooManagerPluginTypeModel *)getDefaultPluginDataWithPluginType:(ZooManagerPluginType)pluginType {
//    NSArray *dataArray = @{
//@[
//                                   @{kTitle:@"Lumberjack"},
//                                   @{kDesc:ZooLocalizedString(@"Lumberjack")},
//                                   @{kIcon:@"zoo_log"},
//                                   @{kPluginName:@"ZooCocoaLumberjackPlugin"},
//                                   @{kAtModule:ZooLocalizedString(@"General")},
//                                   ],
//                           // 性能检测
//                           @(ZooManagerPluginType_ZooMemoryLeakPlugin) : @[
//                                   @{kTitle:ZooLocalizedString(@"内存泄漏")},
//                                   @{kDesc:ZooLocalizedString(@"内存泄漏统计")},
//                                   @{kIcon:@"zoo_memory_leak"},
//                                   @{kPluginName:@"ZooMLeaksFinderPlugin"},
//                                   @{kAtModule:ZooLocalizedString(@"性能检测")}
//                                   ],
//                           // 聚合工具
//                           @(ZooManagerPluginType_ZooHealthPlugin) : @[
//                               @{kTitle:ZooLocalizedString(@"健康体检")},
//                                  @{kDesc:ZooLocalizedString(@"健康体检中心")},
//                                  @{kIcon:@"zoo_health"},
//                                  @{kPluginName:@"ZooHealthPlugin"},
//                                  @{kAtModule:ZooLocalizedString(@"聚合工具")}
//                                  ]
//                           }[@(pluginType)];
//
//    ZooManagerPluginTypeModel *model = [ZooManagerPluginTypeModel new];
//    model.title = dataArray[0][kTitle];
//    model.desc = dataArray[1][kDesc];
//    model.icon = dataArray[2][kIcon];
//    model.pluginName = dataArray[3][kPluginName];
//    model.atModule = dataArray[4][kAtModule];
//
//    return model;
//}

@end
