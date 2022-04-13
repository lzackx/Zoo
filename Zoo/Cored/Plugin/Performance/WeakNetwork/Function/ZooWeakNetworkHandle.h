//
//  ZooWeakNetworkHandle.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooWeakNetworkHandle : NSObject

- (NSData *)weakFlow:(NSData *)data count:(NSInteger)times size:(NSInteger)weakSize;

@end

NS_ASSUME_NONNULL_END
