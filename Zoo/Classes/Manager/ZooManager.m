//
//  ZooManager.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.
#import <UIKit/UIKit.h>
#import "ZooManager.h"
#import "ZooEntryWindow.h"
#import "ZooCacheManager.h"
#import "ZooStartPluginProtocol.h"
#import "ZooDefine.h"
#import "ZooUtil.h"
#import "ZooHomeWindow.h"
#import "ZooHomeWindow.h"


@implementation ZooManagerPluginTypeModel

@end


@interface ZooManager()

@property (nonatomic, strong) ZooEntryWindow *entryWindow;

@property (nonatomic, strong) NSMutableArray *startPlugins;

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
    
    customBlock();

    [self initEntry:self.startingPosition];
    
}

/**
 初始化工具入口
 */
- (void)initEntry:(CGPoint) startingPosition{
    _entryWindow = [[ZooEntryWindow alloc] initWithStartPoint:startingPosition];
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

- (void)addPluginWithTitle:(NSString *)title icon:(NSString *)iconName desc:(NSString *)desc pluginName:(NSString *)entryName atModule:(NSString *)moduleName{
    
    NSMutableDictionary *pluginDic = [self foundGroupWithModule:moduleName];
    pluginDic[@"key"] = [NSString stringWithFormat:@"%@-%@-%@-%@",moduleName,title,iconName,desc];
    pluginDic[@"name"] = title;
    pluginDic[@"icon"] = iconName;
    pluginDic[@"desc"] = desc;
    pluginDic[@"pluginName"] = entryName;
    pluginDic[@"show"] = @1;
}

- (void)addPluginWithTitle:(NSString *)title
                      icon:(NSString *)iconName
                      desc:(NSString *)desc
                pluginName:(NSString *)entryName
                  atModule:(NSString *)moduleName
                    handle:(void (^)(NSDictionary *))handleBlock {
    NSMutableDictionary *pluginDic = [self foundGroupWithModule:moduleName];
    pluginDic[@"key"] = [NSString stringWithFormat:@"%@-%@-%@-%@",moduleName,title,iconName,desc];
    pluginDic[@"name"] = title;
    pluginDic[@"icon"] = iconName;
    pluginDic[@"desc"] = desc;
    pluginDic[@"pluginName"] = entryName;
    [_keyBlockDic setValue:[handleBlock copy] forKey:pluginDic[@"key"]];
    pluginDic[@"show"] = @1;

}

- (void)addPluginWithTitle:(NSString *)title
                     image:(UIImage *)image
                      desc:(NSString *)desc
                pluginName:(NSString *)entryName
                  atModule:(NSString *)moduleName
                    handle:(void (^)(NSDictionary * _Nonnull))handleBlock {
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

- (void)addPluginWithModel:(ZooManagerPluginTypeModel *)model {
    [self addPluginWithTitle:model.title icon:model.icon desc:model.desc pluginName:model.pluginName atModule:model.atModule];
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

- (void)hiddenHomeWindow{
    [[ZooHomeWindow shareInstance] hide];
}

- (void)configEntryBtnBlingWithText:(NSString *)text backColor:(UIColor *)backColor {
    [self.entryWindow configEntryBtnBlingWithText:text backColor:backColor];
}

@end
