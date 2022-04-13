//
//  ZooTimeProfilerRecord.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

// 一条 OC 函数 调用记录
@interface ZooTimeProfilerRecord : NSObject

@property (nonatomic, strong) NSString *className;
@property (nonatomic, strong) NSString *methodName;
@property (nonatomic, assign) BOOL isClassMethod;
@property (nonatomic, assign) NSTimeInterval timeCost;
@property (nonatomic, assign) NSUInteger callDepth;
@property (nonatomic, strong) NSArray <ZooTimeProfilerRecord *>*subRecords;

- (NSString *)descriptionWithDepth ;

@end

NS_ASSUME_NONNULL_END
