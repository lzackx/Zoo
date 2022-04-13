//
//  ZooOscillogramWindowManager.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface ZooOscillogramWindowManager : NSObject

+ (ZooOscillogramWindowManager *)shareInstance;

- (void)resetLayout;

@end

NS_ASSUME_NONNULL_END
