//
//  ZooManager.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
typedef void (^ZooH5DoorBlock)(NSString *);
typedef UIImage * _Nullable (^ZooWebpHandleBlock)(NSString *filePath);

typedef NS_ENUM(NSUInteger, ZooManagerPluginType) {
    #pragma mark - 常用工具
    // App设置
    ZooManagerPluginType_ZooAppSettingPlugin,
    // App信息
    ZooManagerPluginType_ZooAppInfoPlugin,
    // 沙盒浏览
    ZooManagerPluginType_ZooSandboxPlugin,
    // MockGPS
    ZooManagerPluginType_ZooGPSPlugin,
    // H5任意门
    ZooManagerPluginType_ZooH5Plugin,
    // Crash查看
    ZooManagerPluginType_ZooCrashPlugin,
    // 子线程UI
    ZooManagerPluginType_ZooSubThreadUICheckPlugin,
    // 清理缓存
    ZooManagerPluginType_ZooDeleteLocalDataPlugin,
    // NSLog
    ZooManagerPluginType_ZooNSLogPlugin,
    // 日志显示
    ZooManagerPluginType_ZooCocoaLumberjackPlugin,
    // 数据库工具
    ZooManagerPluginType_ZooDatabasePlugin,
    // NSUserDefaults工具
    ZooManagerPluginType_ZooNSUserDefaultsPlugin,
    
    #pragma mark - 性能检测
    // 帧率监控
    ZooManagerPluginType_ZooFPSPlugin,
    // CPU监控
    ZooManagerPluginType_ZooCPUPlugin,
    // 内存监控
    ZooManagerPluginType_ZooMemoryPlugin,
    // 流量监控
    ZooManagerPluginType_ZooNetFlowPlugin,
    // 卡顿检测
    ZooManagerPluginType_ZooANRPlugin,
    // Load耗时
    ZooManagerPluginType_ZooMethodUseTimePlugin,
    // 大图检测
    ZooManagerPluginType_ZooLargeImageFilter,
    // 启动耗时
    ZooManagerPluginType_ZooStartTimePlugin,
    // 内存泄漏
    ZooManagerPluginType_ZooMemoryLeakPlugin,
    // UI层级检查
    ZooManagerPluginType_ZooUIProfilePlugin,
    // UI结构调整
    ZooManagerPluginType_ZooHierarchyPlugin,
    // 函数耗时
    ZooManagerPluginType_ZooTimeProfilePlugin,
    // 模拟弱网
    ZooManagerPluginType_ZooWeakNetworkPlugin,
    
    #pragma mark - 视觉工具
    // 颜色吸管
    ZooManagerPluginType_ZooColorPickPlugin,
    // 组件检查
    ZooManagerPluginType_ZooViewCheckPlugin,
    // 对齐标尺
    ZooManagerPluginType_ZooViewAlignPlugin,
    // 元素边框线
    ZooManagerPluginType_ZooViewMetricsPlugin,
    
};

@interface ZooManagerPluginTypeModel : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *desc;
@property(nonatomic, copy) NSString *icon;
@property(nonatomic, copy) NSString *pluginName;
@property(nonatomic, copy) NSString *atModule;
@property(nonatomic, copy) NSString *buriedPoint;

@end

@interface ZooManager : NSObject

+ (nonnull ZooManager *)shareInstance;

@property (nonatomic, copy) NSString *mockDomain; //产品mockDomain 非必填 默认mock.zoo.cn

@property (nonatomic, assign) BOOL autoDock; //zoo entry icon support autoDock，deffault yes

- (void)install;

// 自定义平台mockDomain初始化方式
- (void)installWithMockDomain:(NSString *)mockDomain;

// 定制起始位置 | 适用正好挡住关键位置
- (void)installWithStartingPosition:(CGPoint) position;

- (void)installWithCustomBlock:(void(^)(void))customBlock;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic, copy) ZooH5DoorBlock h5DoorBlock;
@property (nonatomic, copy) ZooWebpHandleBlock webpHandleBlock;

- (void)addPluginWithTitle:(NSString *)title icon:(NSString *)iconName desc:(NSString *)desc pluginName:(NSString *)entryName atModule:(NSString *)moduleName;
- (void)addPluginWithTitle:(NSString *)title icon:(NSString *)iconName desc:(NSString *)desc pluginName:(NSString *)entryName atModule:(NSString *)moduleName handle:(void(^)(NSDictionary *itemData))handleBlock;

- (void)addPluginWithTitle:(NSString *)title image:(UIImage *)image desc:(NSString *)desc pluginName:(NSString *)entryName atModule:(NSString *)moduleName handle:(void(^ _Nullable)(NSDictionary *itemData))handleBlock;


- (void)removePluginWithPluginType:(ZooManagerPluginType)pluginType;

- (void)removePluginWithPluginName:(NSString *)pluginName atModule:(NSString *)moduleName;

- (void)addStartPlugin:(NSString *)pluginName;

- (void)addH5DoorBlock:(ZooH5DoorBlock)block;

- (void)addANRBlock:(void(^)(NSDictionary *anrDic))block;

- (void)addPerformanceBlock:(void(^)(NSDictionary *performanceDic))block;

- (void)addWebpHandleBlock:(ZooWebpHandleBlock)block;

- (BOOL)isShowZoo;

- (void)showZoo;

- (void)hiddenZoo;

- (void)hiddenHomeWindow;

@property (nonatomic, assign) int64_t bigImageDetectionSize; // 外部设置大图检测的监控数值  比如监控所有图片大于50K的图片 那么这个值就设置为 50 * 1024；

@property (nonatomic, copy) NSString *startClass; //如果你的启动代理不是默认的AppDelegate,需要传入才能获取正确的启动时间

@property (nonatomic, copy) NSArray *vcProfilerBlackList;//使用vcProfiler的使用，兼容一些异常情况，比如issue416

@property (nonatomic, strong) NSMutableDictionary *keyBlockDic;//保存key和block的关系

/// Zoo 支持的旋转方向
@property (assign, nonatomic) UIInterfaceOrientationMask supportedInterfaceOrientations;


- (void)configEntryBtnBlingWithText:(nullable NSString *)text backColor:(nullable UIColor *)backColor;
@end
NS_ASSUME_NONNULL_END
