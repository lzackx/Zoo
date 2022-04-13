//
//  ZooMockUtil.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooMockUtil.h"
#import "ZooUtil.h"
#import "ZooMockManager.h"
#import "ZooDefine.h"

#define ZooMockFileName @"mock"
#define ZooUploadFileName @"upload"

@interface ZooMockUtil()

@end

@implementation ZooMockUtil

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
    }
    return self;
}

- (void)saveMockArrayCache{
    NSMutableArray<ZooMockAPIModel *> *mockArray = [ZooMockManager sharedInstance].mockArray;
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for (ZooMockAPIModel *api in mockArray) {
        if (api.selected) {
            NSMutableDictionary *apiDic = [[NSMutableDictionary alloc] init];
            [apiDic setValue:api.apiId forKey:@"apiId"];
            NSArray<ZooMockScene *> *sceneList = api.sceneList;
            for (ZooMockScene *scene in sceneList) {
                if (scene.selected) {
                    [apiDic setValue:scene.sceneId forKey:@"sceneId"];
                    break;
                }
            }
            [dataArray addObject:apiDic];
        }
    }
    
    [self saveArray:dataArray toFile:ZooMockFileName];
}

- (void)saveUploadArrayCache{
    NSMutableArray<ZooMockUpLoadModel *> *upLoadArray = [ZooMockManager sharedInstance].upLoadArray;
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for (ZooMockUpLoadModel *upload in upLoadArray) {
        if (upload.selected) {
            NSMutableDictionary *uploadDic = [[NSMutableDictionary alloc] init];
            [uploadDic setValue:upload.apiId forKey:@"apiId"];
            if(upload.result.length>0){
                [uploadDic setValue:upload.result forKey:@"result"];
            }
            [dataArray addObject:uploadDic];
        }
    }
    
    [self saveArray:dataArray toFile:ZooUploadFileName];
}

- (void)readMockArrayCache{
    NSMutableArray<ZooMockAPIModel *> *mockArray = [ZooMockManager sharedInstance].mockArray;
    for (ZooMockAPIModel *api in mockArray) {
        NSString *apiId = api.apiId;
        NSArray *dataArray = [self getArrayFromFile:ZooMockFileName];
        for (NSDictionary *apiDic in dataArray) {
            if([apiId isEqualToString:apiDic[@"apiId"]]){
                api.selected = YES;
                for (ZooMockScene *scene in api.sceneList) {
                    if ([scene.sceneId isEqualToString: apiDic[@"sceneId"]]) {
                        scene.selected = YES;
                        break;
                    }
                }
                break;
            }
        }
    }
}

- (void)readUploadArrayCache{
    NSMutableArray<ZooMockUpLoadModel *> *upLoadArray = [ZooMockManager sharedInstance].upLoadArray;
    for (ZooMockUpLoadModel *upload in upLoadArray) {
        NSArray *dataArray = [self getArrayFromFile:ZooUploadFileName];
        for (NSDictionary *uploadDic in dataArray) {
            if ([upload.apiId isEqualToString:uploadDic[@"apiId"]]) {
                upload.selected = YES;
                if (uploadDic[@"result"]){
                    upload.result = uploadDic[@"result"];
                }
                break;
            }
        }
    }
}

- (void)saveArray:(NSArray *)dataArray toFile:(NSString *)fileName{
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *anrDir = [cachesDir stringByAppendingPathComponent:@"ZooMockCache"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL existed = [fileManager fileExistsAtPath:anrDir isDirectory:&isDir];
    if(!(isDir && existed)){
        [fileManager createDirectoryAtPath:anrDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *path = [anrDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json",fileName]];
    NSString *text = [ZooUtil arrayToJsonStr:dataArray];
    BOOL writeSuccess = [text writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (writeSuccess) {
        ZooLog(@"写入成功");
    }
}

- (NSArray *)getArrayFromFile:(NSString *)fileName{
    NSArray *dataArray;
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *anrDir = [cachesDir stringByAppendingPathComponent:@"ZooMockCache"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL existed = [fileManager fileExistsAtPath:anrDir isDirectory:&isDir];
    if (existed){
        NSString *path = [anrDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json",fileName]];
        NSError *error = nil;
        NSString *json = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        dataArray = [ZooUtil arrayWithJsonString:json];
    }
    return dataArray;
}

@end
