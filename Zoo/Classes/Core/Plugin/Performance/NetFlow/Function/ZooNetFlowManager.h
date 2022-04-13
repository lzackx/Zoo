//
//  ZooNetFlowManager.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <Foundation/Foundation.h>

typedef void(^HttpBodyCallBack)(NSData *body);

@interface ZooNetFlowManager : NSObject

+ (ZooNetFlowManager *)shareInstance;

@property (nonatomic, strong) NSDate *startInterceptDate;
@property (nonatomic, assign) BOOL canIntercept;

- (void)canInterceptNetFlow:(BOOL)enable;

- (void)httpBodyFromRequest:(NSURLRequest *)request bodyCallBack:(HttpBodyCallBack)complete;

@end
