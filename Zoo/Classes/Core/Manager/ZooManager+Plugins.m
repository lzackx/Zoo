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

#pragma mark - Core
- (void)addCorePlugins {
    [self addPluginWithPluginType:ZooManagerPluginType_ZooAppSettingPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooAppInfoPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooSandboxPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooH5Plugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooDeleteLocalDataPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooNSLogPlugin];
    [self addPluginWithPluginType:ZooManagerPluginType_ZooNSUserDefaultsPlugin];
}

#pragma mark - Platform
- (void)addPlatformPlugins {
#if ZooWithPlatform
    [self addPluginWithPluginType:ZooManagerPluginType_ZooHealthPlugin];
#endif
}

#pragma mark - Performance
- (void)addPerformancePlugins {
#if ZooWithPerformance
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

#pragma mark - default data
- (void)addPluginWithPluginType:(ZooManagerPluginType)pluginType {
    ZooManagerPluginTypeModel *model = [self getDefaultPluginDataWithPluginType:pluginType];
    [self addPluginWithTitle:model.title icon:model.icon desc:model.desc pluginName:model.pluginName atModule:model.atModule];
}

- (void)removePluginWithPluginType:(ZooManagerPluginType)pluginType
{
    ZooManagerPluginTypeModel *model = [self getDefaultPluginDataWithPluginType:pluginType];
    [self removePluginWithPluginName:model.pluginName atModule:model.atModule];
}

- (ZooManagerPluginTypeModel *)getDefaultPluginDataWithPluginType:(ZooManagerPluginType)pluginType {
    NSArray *dataArray = @{
                           @(ZooManagerPluginType_ZooAppSettingPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"应用设置")},
                                   @{kDesc:ZooLocalizedString(@"应用设置")},
                                   @{kIcon:@"zoo_setting"},
                                   @{kPluginName:@"ZooAppSettingPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"常用工具")}
                                    ],
                           @(ZooManagerPluginType_ZooAppInfoPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"App信息")},
                                   @{kDesc:ZooLocalizedString(@"App信息")},
                                   @{kIcon:@"zoo_app_info"},
                                   @{kPluginName:@"ZooAppInfoPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"常用工具")}
                                   ],
                           @(ZooManagerPluginType_ZooSandboxPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"沙盒浏览器")},
                                   @{kDesc:ZooLocalizedString(@"沙盒浏览器")},
                                   @{kIcon:@"zoo_file"},
                                   @{kPluginName:@"ZooSandboxPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"常用工具")}
                                   ],
                           @(ZooManagerPluginType_ZooGPSPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"Mock GPS")},
                                   @{kDesc:ZooLocalizedString(@"Mock GPS")},
                                   @{kIcon:@"zoo_mock_gps"},
                                   @{kPluginName:@"ZooGPSPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"常用工具")}
                                   ],
                           @(ZooManagerPluginType_ZooH5Plugin) : @[
                                   @{kTitle:ZooLocalizedString(@"H5任意门")},
                                   @{kDesc:ZooLocalizedString(@"H5任意门")},
                                   @{kIcon:@"zoo_h5"},
                                   @{kPluginName:@"ZooH5Plugin"},
                                   @{kAtModule:ZooLocalizedString(@"常用工具")}
                                   ],
                           @(ZooManagerPluginType_ZooDeleteLocalDataPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"清理缓存")},
                                   @{kDesc:ZooLocalizedString(@"清理缓存")},
                                   @{kIcon:@"zoo_qingchu"},
                                   @{kPluginName:@"ZooDeleteLocalDataPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"常用工具")}
                                   ],
                           @(ZooManagerPluginType_ZooNSLogPlugin) : @[
                                   @{kTitle:@"NSLog"},
                                   @{kDesc:@"NSLog"},
                                   @{kIcon:@"zoo_nslog"},
                                   @{kPluginName:@"ZooNSLogPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"常用工具")}
                                   ],
                           @(ZooManagerPluginType_ZooCocoaLumberjackPlugin) : @[
                                   @{kTitle:@"Lumberjack"},
                                   @{kDesc:ZooLocalizedString(@"Lumberjack")},
                                   @{kIcon:@"zoo_log"},
                                   @{kPluginName:@"ZooCocoaLumberjackPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"常用工具")}
                                   ],
                           @(ZooManagerPluginType_ZooNSUserDefaultsPlugin) : @[
                                   @{kTitle:@"UserDefaults"},
                                   @{kDesc:@"UserDefaults"},
                                   @{kIcon:@"zoo_database"},
                                   @{kPluginName:@"ZooNSUserDefaultsPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"常用工具")}
                           ],
                           
                           // 性能检测
                           @(ZooManagerPluginType_ZooFPSPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"帧率")},
                                   @{kDesc:ZooLocalizedString(@"帧率")},
                                   @{kIcon:@"zoo_fps"},
                                   @{kPluginName:@"ZooFPSPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")}
                                   ],
                           @(ZooManagerPluginType_ZooCPUPlugin) : @[
                                   @{kTitle:@"CPU"},
                                   @{kDesc:ZooLocalizedString(@"CPU")},
                                   @{kIcon:@"zoo_cpu"},
                                   @{kPluginName:@"ZooCPUPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")}
                                   ],
                           @(ZooManagerPluginType_ZooMemoryPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"内存")},
                                   @{kDesc:ZooLocalizedString(@"内存")},
                                   @{kIcon:@"zoo_memory"},
                                   @{kPluginName:@"ZooMemoryPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")}
                                   ],
                           @(ZooManagerPluginType_ZooNetFlowPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"网络")},
                                   @{kDesc:ZooLocalizedString(@"网络监控")},
                                   @{kIcon:@"zoo_net"},
                                   @{kPluginName:@"ZooNetFlowPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")}
                                   ],
                           @(ZooManagerPluginType_ZooCrashPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"Crash")},
                                   @{kDesc:ZooLocalizedString(@"Crash")},
                                   @{kIcon:@"zoo_crash"},
                                   @{kPluginName:@"ZooCrashPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")}
                                   ],
                           @(ZooManagerPluginType_ZooSubThreadUICheckPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"子线程UI")},
                                   @{kDesc:ZooLocalizedString(@"子线程UI")},
                                   @{kIcon:@"zoo_ui"},
                                   @{kPluginName:@"ZooSubThreadUICheckPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")}
                                   ],
                           @(ZooManagerPluginType_ZooANRPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"卡顿")},
                                   @{kDesc:ZooLocalizedString(@"卡顿")},
                                   @{kIcon:@"zoo_kadun"},
                                   @{kPluginName:@"ZooANRPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")}
                                   ],
                           @(ZooManagerPluginType_ZooLargeImageFilter) : @[
                                   @{kTitle:ZooLocalizedString(@"大图检测")},
                                   @{kDesc:ZooLocalizedString(@"大图检测")},
                                   @{kIcon:@"zoo_net"},
                                   @{kPluginName:@"ZooLargeImagePlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")}
                                   ],
                           @(ZooManagerPluginType_ZooStartTimePlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"启动耗时")},
                                   @{kDesc:ZooLocalizedString(@"启动耗时")},
                                   @{kIcon:@"zoo_app_start_time"},
                                   @{kPluginName:@"ZooStartTimePlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")}
                                   ],
                           @(ZooManagerPluginType_ZooMemoryLeakPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"内存泄漏")},
                                   @{kDesc:ZooLocalizedString(@"内存泄漏统计")},
                                   @{kIcon:@"zoo_memory_leak"},
                                   @{kPluginName:@"ZooMLeaksFinderPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")}
                                   ],
                           @(ZooManagerPluginType_ZooUIProfilePlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"UI层级")},
                                   @{kDesc:ZooLocalizedString(@"UI层级s")},
                                   @{kIcon:@"zoo_view_level"},
                                   @{kPluginName:@"ZooUIProfilePlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")}
                           ],
                           @(ZooManagerPluginType_ZooTimeProfilePlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"函数耗时")},
                                   @{kDesc:ZooLocalizedString(@"函数耗时统计")},
                                   @{kIcon:@"zoo_time_profiler"},
                                   @{kPluginName:@"ZooTimeProfilerPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"性能检测")}
                           ],
                           @(ZooManagerPluginType_ZooWeakNetworkPlugin) : @[
                                     @{kTitle:ZooLocalizedString(@"模拟弱网")},
                                     @{kDesc:ZooLocalizedString(@"模拟弱网测试")},
                                     @{kIcon:@"zoo_weaknet"},
                                     @{kPluginName:@"ZooWeakNetworkPlugin"},
                                     @{kAtModule:ZooLocalizedString(@"性能检测")}
                             ],
                           // 视觉工具
                           @(ZooManagerPluginType_ZooColorPickPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"取色器")},
                                   @{kDesc:ZooLocalizedString(@"取色器")},
                                   @{kIcon:@"zoo_straw"},
                                   @{kPluginName:@"ZooColorPickPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"视觉工具")}
                                   ],
                           @(ZooManagerPluginType_ZooViewCheckPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"组件检查")},
                                   @{kDesc:ZooLocalizedString(@"组件检查")},
                                   @{kIcon:@"zoo_view_check"},
                                   @{kPluginName:@"ZooViewCheckPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"视觉工具")}
                                   ],
                           @(ZooManagerPluginType_ZooViewAlignPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"对齐标尺")},
                                   @{kDesc:ZooLocalizedString(@"对齐标尺")},
                                   @{kIcon:@"zoo_align"},
                                   @{kPluginName:@"ZooViewAlignPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"视觉工具")}
                                   ],
                           @(ZooManagerPluginType_ZooViewMetricsPlugin) : @[
                                   @{kTitle:ZooLocalizedString(@"布局边框")},
                                   @{kDesc:ZooLocalizedString(@"布局边框")},
                                   @{kIcon:@"zoo_viewmetrics"},
                                   @{kPluginName:@"ZooViewMetricsPlugin"},
                                   @{kAtModule:ZooLocalizedString(@"视觉工具")}
                                   ],
                          @(ZooManagerPluginType_ZooHierarchyPlugin) : @[
                                           @{kTitle:ZooLocalizedString(@"UI结构")},
                                           @{kDesc:ZooLocalizedString(@"显示UI结构")},
                                           @{kIcon:@"zoo_view_level"},
                                           @{kPluginName:@"ZooHierarchyPlugin"},
                                           @{kAtModule:ZooLocalizedString(@"视觉工具")}
                                   ],
                           // 聚合工具
                           @(ZooManagerPluginType_ZooHealthPlugin) : @[
                               @{kTitle:ZooLocalizedString(@"健康体检")},
                                  @{kDesc:ZooLocalizedString(@"健康体检中心")},
                                  @{kIcon:@"zoo_health"},
                                  @{kPluginName:@"ZooHealthPlugin"},
                                  @{kAtModule:ZooLocalizedString(@"聚合工具")}
                                  ]
                           }[@(pluginType)];
    
    ZooManagerPluginTypeModel *model = [ZooManagerPluginTypeModel new];
    model.title = dataArray[0][kTitle];
    model.desc = dataArray[1][kDesc];
    model.icon = dataArray[2][kIcon];
    model.pluginName = dataArray[3][kPluginName];
    model.atModule = dataArray[4][kAtModule];
    
    return model;
}

@end
