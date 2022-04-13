//
//  ZooMockAPI.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <Foundation/Foundation.h>
#import "ZooMockBaseModel.h"
#import "ZooMockScene.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZooMockAPIModel : ZooMockBaseModel

//业务数据
@property (nonatomic, copy) NSArray<ZooMockScene *> *sceneList;

@end

NS_ASSUME_NONNULL_END
