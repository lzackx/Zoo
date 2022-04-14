//
//  ZooNetworkUtil.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ZooNetworkSucceedCallback)(NSDictionary *result);
typedef void (^ZooNetworkFailureCallback)(NSError *error);

#define ZooNetworkUtilUrl

@interface ZooNetworkUtil : NSObject
// get 请求
+ (void)getWithUrlString:(NSString *)url params:(NSDictionary *)params success:(ZooNetworkSucceedCallback)successAction
error:(ZooNetworkFailureCallback)errorAction;

// post 请求
+ (void)postWithUrlString:(NSString *)url params:(NSDictionary *)params success:(ZooNetworkSucceedCallback)successAction
error:(ZooNetworkFailureCallback)errorAction;

// patch请求
+ (void)patchWithUrlString:(NSString *)url params:(NSDictionary *)params success:(ZooNetworkSucceedCallback)successAction error:(ZooNetworkFailureCallback)errorAction;


@end

NS_ASSUME_NONNULL_END
