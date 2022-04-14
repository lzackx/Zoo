//
//  ZooMockAPI.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <Foundation/Foundation.h>
#import "ZooMockBaseModel.h"
#import "ZooMockScene.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZooMockAPIModel : ZooMockBaseModel

//业务数据
@property (nonatomic, copy) NSArray<ZooMockScene *> *sceneList;

@end

NS_ASSUME_NONNULL_END
