//
//  ZooViewAlignManager.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import <Foundation/Foundation.h>

@interface ZooViewAlignManager : NSObject

+ (ZooViewAlignManager *)shareInstance;

- (void)show;

- (void)hidden;

@end
