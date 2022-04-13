//
//  ZooMockUtil.h
//  ZooKit
//
//  Created by lZackx on 04/12/2022 
//

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
