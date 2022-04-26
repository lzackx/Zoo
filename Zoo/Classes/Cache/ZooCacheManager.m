//
//  ZooCacheManager.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooCacheManager.h"
#import "ZooManager.h"
#import "ZooDefine.h"


@interface ZooCacheManager()

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
    }
    return self;
}

@end
