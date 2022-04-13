//
//  ZooSubThreadUICheckManager.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <Foundation/Foundation.h>

@interface ZooSubThreadUICheckManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) NSMutableArray *checkArray;

@end
