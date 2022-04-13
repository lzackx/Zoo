//
//  ZooMockScene.h
//  ZooKit
//
//  Created by lZackx on 04/12/2022 
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooMockScene : NSObject

@property (nonatomic, copy) NSString *sceneId;//场景id
@property (nonatomic, copy) NSString *name;//场景名称
@property (nonatomic, assign) BOOL selected;//是否选中

@end

NS_ASSUME_NONNULL_END
