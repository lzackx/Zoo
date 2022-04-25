//
//  ZooManager.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ZooManagerPluginType) {
    #pragma mark - 常用工具
    // MockGPS
    ZooManagerPluginType_ZooGPSPlugin,
    // 子线程UI
    ZooManagerPluginType_ZooSubThreadUICheckPlugin,
    // 日志显示
    ZooManagerPluginType_ZooCocoaLumberjackPlugin,
    
    #pragma mark - 性能检测
    // 内存泄漏
    ZooManagerPluginType_ZooMemoryLeakPlugin,
    
    #pragma mark - 视觉工具
    // 颜色吸管
    ZooManagerPluginType_ZooColorPickPlugin,
    // 组件检查
    ZooManagerPluginType_ZooViewCheckPlugin,
    // 对齐标尺
    ZooManagerPluginType_ZooViewAlignPlugin,
    // 元素边框线
    ZooManagerPluginType_ZooViewMetricsPlugin,
    
    #pragma mark - 聚合工具
    ZooManagerPluginType_ZooHealthPlugin
};

@interface ZooManagerPluginTypeModel : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *desc;
@property(nonatomic, copy) NSString *icon;
@property(nonatomic, copy) NSString *pluginName;
@property(nonatomic, copy) NSString *atModule;

@end

@interface ZooManager : NSObject

+ (nonnull ZooManager *)shareInstance;

@property (nonatomic, assign) BOOL autoDock; //zoo entry icon support autoDock，deffault yes

- (void)install;

// 定制起始位置 | 适用正好挡住关键位置
- (void)installWithStartingPosition:(CGPoint)position;

- (void)installWithCustomBlock:(void(^)(void))customBlock;

#pragma mark - Plugins Data
@property (nonatomic,strong) NSMutableArray *dataArray;

#pragma mark - Add
- (void)addPluginWithTitle:(NSString *)title
                      icon:(NSString *)iconName
                      desc:(NSString *)desc
                pluginName:(NSString *)entryName
                  atModule:(NSString *)moduleName;

- (void)addPluginWithTitle:(NSString *)title
                      icon:(NSString *)iconName
                      desc:(NSString *)desc
                pluginName:(NSString *)entryName
                  atModule:(NSString *)moduleName
                    handle:(void(^)(NSDictionary *itemData))handleBlock;

- (void)addPluginWithTitle:(NSString *)title
                     image:(UIImage *)image
                      desc:(NSString *)desc
                pluginName:(NSString *)entryName
                  atModule:(NSString *)moduleName
                    handle:(void(^ _Nullable)(NSDictionary *itemData))handleBlock;

- (void)addPluginWithModel:(ZooManagerPluginTypeModel *)model;

#pragma mark - Remove
- (void)removePluginWithPluginName:(NSString *)pluginName atModule:(NSString *)moduleName;


#pragma mark - Configuration
/// Zoo 支持的旋转方向
@property (assign, nonatomic) UIInterfaceOrientationMask supportedInterfaceOrientations;

- (void)configEntryBtnBlingWithText:(nullable NSString *)text backColor:(nullable UIColor *)backColor;


#pragma mark - Show / Hidden/
- (BOOL)isShowZoo;

- (void)showZoo;

- (void)hiddenZoo;

- (void)hiddenHomeWindow;

#pragma mark - Plugins Configuration

- (void)addStartPlugin:(NSString *)pluginName;

@property (nonatomic, strong) NSMutableDictionary *keyBlockDic;//保存key和block的关系

@end
NS_ASSUME_NONNULL_END
