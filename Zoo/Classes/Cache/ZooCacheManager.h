//
//  ZooCacheManager.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <Foundation/Foundation.h>

@interface ZooCacheManager : NSObject

+ (ZooCacheManager *)sharedInstance;

// Kit Manager数据保存
- (void)saveKitManagerData:(NSMutableArray *)dataArray;
- (NSMutableArray *)kitManagerData;
- (NSMutableArray *)kitShowManagerData;
- (NSMutableArray *)allKitShowManagerData;

@end
