//
//  ZooCacheManager.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooCacheManager.h"
#import "ZooManager.h"
#import "ZooDefine.h"


#define kZooManagerKey [NSString stringWithFormat:@"%@_zoo_kit_manager_key", ZooVersion]

@interface ZooCacheManager()

@property (nonatomic, strong) NSUserDefaults *defaults;

@end

@implementation ZooCacheManager

+ (ZooCacheManager *)sharedInstance{
    static dispatch_once_t once;
    static ZooCacheManager *instance;
    dispatch_once(&once, ^{
        instance = [[ZooCacheManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self  = [super init];
    if (self) {
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

// Kit Manager数据保存 只保存内部数据
- (void)saveKitManagerData:(NSArray *)dataArray{
    NSMutableArray *mutableDataArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in dataArray) {
        NSString *moduleName = dic[@"moduleName"];
        if (moduleName && ([moduleName isEqualToString:ZooLocalizedString(@"General")])) {
            NSArray *pluginArray = dic[@"pluginArray"];
            NSMutableArray *mutablepluginArray = [[NSMutableArray alloc] init];
            for (NSDictionary *subDic in pluginArray){
                [mutablepluginArray addObject:subDic.mutableCopy];
            }
            NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
            [mutableDic setValue:dic[@"moduleName"] forKey:@"moduleName"];
            [mutableDic setValue:mutablepluginArray forKey:@"pluginArray"];
            
            [mutableDataArray addObject:mutableDic];
        }

    }
    [_defaults setObject:mutableDataArray forKey:kZooManagerKey];
    [_defaults synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:ZooManagerUpdateNotification object:nil userInfo:nil];
}

- (NSMutableArray *)kitManagerData{
    //NSUserDefaults返回的对象都是不可变的,第一步要不他们都要变成可变的
    NSArray *dataArray = [_defaults objectForKey:kZooManagerKey];
    NSMutableArray *mutableDataArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in dataArray) {
        NSArray *pluginArray = dic[@"pluginArray"];
        NSMutableArray *mutablepluginArray = [[NSMutableArray alloc] init];
        for (NSDictionary *subDic in pluginArray){
            [mutablepluginArray addObject:subDic.mutableCopy];
        }
        NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
        [mutableDic setValue:dic[@"moduleName"] forKey:@"moduleName"];
        [mutableDic setValue:mutablepluginArray forKey:@"pluginArray"];
        
        [mutableDataArray addObject:mutableDic];
    }
    return mutableDataArray;
}

- (NSMutableArray *)kitShowManagerData{
    //NSUserDefaults返回的对象都是不可变的,第一步要不他们都要变成可变的
    NSArray *dataArray = [_defaults objectForKey:kZooManagerKey];
    NSMutableArray *mutableDataArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in dataArray) {
        NSArray *pluginArray = dic[@"pluginArray"];
        NSMutableArray *mutablepluginArray = [[NSMutableArray alloc] init];
        for (NSDictionary *subDic in pluginArray){
            BOOL show = [subDic[@"show"] boolValue];
            if (show) {
                [mutablepluginArray addObject:subDic.mutableCopy];
            }
        }
        NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
        [mutableDic setValue:dic[@"moduleName"] forKey:@"moduleName"];
        [mutableDic setValue:mutablepluginArray forKey:@"pluginArray"];
        
        [mutableDataArray addObject:mutableDic];
    }
    return mutableDataArray;
}

//外部数据+保存数据
- (NSMutableArray *)allKitShowManagerData{
     NSMutableArray *dataArray = [ZooManager shareInstance].dataArray;
    NSMutableArray *mutableDataArray = [[NSMutableArray alloc] init];
    if ([self kitShowManagerData].count>0) {
        for (NSDictionary *dic in dataArray) {
            NSString *moduleName = dic[@"moduleName"];
            if (moduleName && ([moduleName isEqualToString:ZooLocalizedString(@"General")])) {
                continue;
            }
            
            NSArray *pluginArray = dic[@"pluginArray"];
            NSMutableArray *mutablepluginArray = [[NSMutableArray alloc] init];
            for (NSDictionary *subDic in pluginArray){
                [mutablepluginArray addObject:subDic.mutableCopy];
            }
            NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
            [mutableDic setValue:dic[@"moduleName"] forKey:@"moduleName"];
            [mutableDic setValue:mutablepluginArray forKey:@"pluginArray"];
            
            [mutableDataArray addObject:mutableDic];

        }
        [mutableDataArray addObjectsFromArray:[self kitShowManagerData]];
    }else{
        NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
        for (NSDictionary *dic in dataArray) {
            NSString *moduleName = dic[@"moduleName"];
            if (moduleName && ([moduleName isEqualToString:ZooLocalizedString(@"General")])) {
                [mutableDataArray addObject:dic];
                continue;
            }
            
            NSArray *pluginArray = dic[@"pluginArray"];
            NSMutableArray *mutablepluginArray = [[NSMutableArray alloc] init];
            for (NSDictionary *subDic in pluginArray){
                [mutablepluginArray addObject:subDic.mutableCopy];
            }
            [mutableDic setValue:dic[@"moduleName"] forKey:@"moduleName"];
            [mutableDic setValue:mutablepluginArray forKey:@"pluginArray"];
        }
        if (mutableDic.allKeys.count) {
            [mutableDataArray insertObject:mutableDic atIndex:0];
        }
    }
    
    return mutableDataArray;
}

@end
