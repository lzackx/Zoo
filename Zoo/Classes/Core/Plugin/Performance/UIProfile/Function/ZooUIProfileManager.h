//
//  ZooUIProfileManager.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooUIProfileManager : NSObject

@property (nonatomic, assign) BOOL enable;              //default NO

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
