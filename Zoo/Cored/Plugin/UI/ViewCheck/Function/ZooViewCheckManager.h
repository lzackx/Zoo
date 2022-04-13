//
//  ZooViewCheckManager.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import <Foundation/Foundation.h>

@interface ZooViewCheckManager : NSObject

+ (ZooViewCheckManager *)shareInstance;

- (void)show;

- (void)hidden;

@end
