//
//  ZooNetFlowDataSource.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <Foundation/Foundation.h>
#import "ZooNetFlowHttpModel.h"

@interface ZooNetFlowDataSource : NSObject

@property (nonatomic, strong) NSMutableArray<ZooNetFlowHttpModel *> *httpModelArray;

+ (ZooNetFlowDataSource *)shareInstance;

- (void)addHttpModel:(ZooNetFlowHttpModel *)httpModel;

- (void)clear;

@end
