//
//  ZooDDLogMessage.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooDDLogMessage : NSObject

@property (nonatomic, copy) NSDate *timestamp;
@property (nonatomic, assign) DDLogFlag flag;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, assign) NSInteger line;
@property (nonatomic, copy) NSString *threadId;
@property (nonatomic, copy) NSString *threadName;
@property (nonatomic, assign) BOOL expand;


@end

NS_ASSUME_NONNULL_END
