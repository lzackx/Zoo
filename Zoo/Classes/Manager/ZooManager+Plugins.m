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

#pragma mark - UI
- (void)addUIPlugins {
#if ZooWithUI
    [self addPluginWithPluginType:ZooManagerPluginType_ZooColorPickPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooViewCheckPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooViewAlignPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooViewMetricsPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooHierarchyPlugin];
#endif
}

// MARK: - GPS
- (void)addGPSPlugins {
#if ZooWithGPS
    [self addPluginWithPluginType:ZooManagerPluginType_ZooGPSPlugin];
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
//                           @(ZooManagerPluginType_ZooGPSPlugin) : @[
//                                   @{kTitle:ZooLocalizedString(@"Mock GPS")},
//                                   @{kDesc:ZooLocalizedString(@"Mock GPS")},
//                                   @{kIcon:@"zoo_mock_gps"},
//                                   @{kPluginName:@"ZooGPSPlugin"},
//                                   @{kAtModule:ZooLocalizedString(@"General")}
//                                   ],
//
//                           // 性能检测

//                           @(ZooManagerPluginType_ZooMemoryLeakPlugin) : @[
//                                   @{kTitle:ZooLocalizedString(@"内存泄漏")},
//                                   @{kDesc:ZooLocalizedString(@"内存泄漏统计")},
//                                   @{kIcon:@"zoo_memory_leak"},
//                                   @{kPluginName:@"ZooMLeaksFinderPlugin"},
//                                   @{kAtModule:ZooLocalizedString(@"性能检测")}
//                                   ],
//                           // 视觉工具
//                           @(ZooManagerPluginType_ZooColorPickPlugin) : @[
//                                   @{kTitle:ZooLocalizedString(@"取色器")},
//                                   @{kDesc:ZooLocalizedString(@"取色器")},
//                                   @{kIcon:@"zoo_straw"},
//                                   @{kPluginName:@"ZooColorPickPlugin"},
//                                   @{kAtModule:ZooLocalizedString(@"视觉工具")}
//                                   ],
//                           @(ZooManagerPluginType_ZooViewCheckPlugin) : @[
//                                   @{kTitle:ZooLocalizedString(@"组件检查")},
//                                   @{kDesc:ZooLocalizedString(@"组件检查")},
//                                   @{kIcon:@"zoo_view_check"},
//                                   @{kPluginName:@"ZooViewCheckPlugin"},
//                                   @{kAtModule:ZooLocalizedString(@"视觉工具")}
//                                   ],
//                           @(ZooManagerPluginType_ZooViewAlignPlugin) : @[
//                                   @{kTitle:ZooLocalizedString(@"对齐标尺")},
//                                   @{kDesc:ZooLocalizedString(@"对齐标尺")},
//                                   @{kIcon:@"zoo_align"},
//                                   @{kPluginName:@"ZooViewAlignPlugin"},
//                                   @{kAtModule:ZooLocalizedString(@"视觉工具")}
//                                   ],
//                           @(ZooManagerPluginType_ZooViewMetricsPlugin) : @[
//                                   @{kTitle:ZooLocalizedString(@"布局边框")},
//                                   @{kDesc:ZooLocalizedString(@"布局边框")},
//                                   @{kIcon:@"zoo_viewmetrics"},
//                                   @{kPluginName:@"ZooViewMetricsPlugin"},
//                                   @{kAtModule:ZooLocalizedString(@"视觉工具")}
//                                   ],
//                          @(ZooManagerPluginType_ZooHierarchyPlugin) : @[
//                                           @{kTitle:ZooLocalizedString(@"UI结构")},
//                                           @{kDesc:ZooLocalizedString(@"显示UI结构")},
//                                           @{kIcon:@"zoo_view_level"},
//                                           @{kPluginName:@"ZooHierarchyPlugin"},
//                                           @{kAtModule:ZooLocalizedString(@"视觉工具")}
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
