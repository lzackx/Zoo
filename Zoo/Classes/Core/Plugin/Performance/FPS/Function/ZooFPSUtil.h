//
//  ZooFPSUtil.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ZooFPSBlock)(NSInteger fps);

@interface ZooFPSUtil : NSObject

- (void)start;
- (void)end;
- (void)addFPSBlock:(ZooFPSBlock)block;

@end

NS_ASSUME_NONNULL_END
