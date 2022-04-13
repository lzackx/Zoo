//
//  ZooWeakNetworkHandle.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooWeakNetworkHandle.h"
#import "ZooWeakNetworkManager.h"
#import "ZooNetworkInterceptor.h"

@interface ZooWeakNetworkHandle()

@end

@implementation ZooWeakNetworkHandle

- (NSData *)weakFlow:(NSData *)data count:(NSInteger)times size:(NSInteger)weakSize{
    if(data.length < weakSize){
        return data;
    }
    NSRange range = NSMakeRange(weakSize * times, weakSize);
    NSInteger endPoint = weakSize * (times + 1);
    if(endPoint > data.length || ![ZooWeakNetworkManager shareInstance].shouldWeak){
        endPoint = data.length - weakSize * times;
        range = NSMakeRange(weakSize * times, endPoint);
    }
    return [data subdataWithRange:range];
}

@end
