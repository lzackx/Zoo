//
//  ZooMockScene.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooMockScene : NSObject

@property (nonatomic, copy) NSString *sceneId;//场景id
@property (nonatomic, copy) NSString *name;//场景名称
@property (nonatomic, assign) BOOL selected;//是否选中

@end

NS_ASSUME_NONNULL_END
