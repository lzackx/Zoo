//
//  ZooSubThreadUICheckManager.m
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import "ZooSubThreadUICheckManager.h"

@implementation ZooSubThreadUICheckManager

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if(self){
        _checkArray = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
