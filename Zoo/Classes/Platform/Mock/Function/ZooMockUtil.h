//
//  ZooMockUtil.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooMockUtil : NSObject

+ (instancetype)sharedInstance;

- (void)saveMockArrayCache;

- (void)saveUploadArrayCache;

- (void)readMockArrayCache;

- (void)readUploadArrayCache;

@end

NS_ASSUME_NONNULL_END
