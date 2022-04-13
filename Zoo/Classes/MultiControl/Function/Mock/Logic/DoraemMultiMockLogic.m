//
//  DoraemMultiMockLogic.m
//  DoraemonKit
//
//  Created by wzp on 2021/10/1.
//

#import "DoraemMultiMockLogic.h"
#import "ZooMultiNetWorkSerivce.h"
#import "DoraemMultiMockManger.h"
#import "ZooMultiNetworkInterceptor.h"
#import<CommonCrypto/CommonDigest.h>

/*
 *  一机多控逻辑层 单例
 */

 @interface DoraemMultiMockLogic()

@end

@implementation DoraemMultiMockLogic

/*
 * 关闭网络修改mock
 */
+ (void)closeMultiResponseModifiy{
    [DoraemMultiMockManger sharedInstance].isResponseModifiy = NO;
    [ZooMultiNetworkInterceptor shareInstance].shouldIntercept = NO;
    [[ZooMultiNetworkInterceptor shareInstance] removeDelegate:[DoraemMultiMockManger sharedInstance]];
}


/*
 * 打开网络修改mock
 */
+ (void)openMultiResponseModifiy{
    [self closeMultiWorkINterceptor];
    [DoraemMultiMockManger sharedInstance].isResponseModifiy = YES;
    [ZooMultiNetworkInterceptor shareInstance].shouldIntercept = YES;
    [[ZooMultiNetworkInterceptor shareInstance] addDelegate:[DoraemMultiMockManger sharedInstance]];
}

/*
 * 打开网络mock
 */
+ (void)openMultiWorkINterceptor {
    [self closeMultiResponseModifiy];
    [DoraemMultiMockManger sharedInstance].isResponseModifiy = NO;
    [ZooMultiNetworkInterceptor shareInstance].shouldIntercept = YES;
    [[ZooMultiNetworkInterceptor shareInstance] addDelegate:[DoraemMultiMockManger sharedInstance]];
}

/*
 * 关闭网络mock
 */
+ (void)closeMultiWorkINterceptor {
    [ZooMultiNetworkInterceptor shareInstance].shouldIntercept = NO;
    [[ZooMultiNetworkInterceptor shareInstance] removeDelegate:[DoraemMultiMockManger sharedInstance]];
}

/*
 * 获取全局配置
 */
+ (void)multiControlGetConfigRequest {

    [ZooMultiNetWorkSerivce multiControlGetConfigWithSus:^(id  _Nonnull responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            return;
        }
        NSDictionary *dict = (NSDictionary *)responseObject[@"data"];
        NSDictionary * multiControl = [dict objectForKey:@"multiControl"];
        [DoraemMultiMockManger sharedInstance].excludeArray = [multiControl objectForKey:@"exclude"];
        
    } fail:^(NSError * _Nonnull error) {

    }];
}

/*
 * 开始录制
 */
+ (void)startRecord {
    [ZooMultiNetWorkSerivce startRecordRequestWithSus:^(id  _Nonnull responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            return;
        }
        NSDictionary *dict = (NSDictionary *)responseObject[@"data"];
        [DoraemMultiMockManger sharedInstance].caseId = [dict objectForKey:@"caseId"];
        NSLog(@"[DoraemMultiMockManger sharedInstance].caseId = %@",[DoraemMultiMockManger sharedInstance].caseId);
        
        if ([DoraemMultiMockManger sharedInstance].caseId == nil || [DoraemMultiMockManger sharedInstance].caseId.length == 0) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"caseId为空的？" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } fail:^(NSError * _Nonnull error) {
        
    }];

}

/*
 * 结束录制
 */
+ (void)endRecordWithPersonName:(NSString *)personName
                       caseName:(NSString *)caseName
                            sus:(void(^)(id _Nonnull responseObject))sus
                           fail:(void (^) (NSError *_Nonnull error))fail {
    
    [ZooMultiNetWorkSerivce endRecordWithCaseID:[DoraemMultiMockManger sharedInstance].caseId  personName:personName caseName:caseName sus:^(id  _Nonnull responseObject) {
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            return;
        }
        NSDictionary *dict = (NSDictionary *)responseObject[@"data"];
        
    } fail:^(NSError * _Nonnull error) {
        
    }];
}


/*
 * 接口信息上传
 */
+ (void)uploadApiInfoWithPath:(NSString *)path{
    
    
    [ZooMultiNetWorkSerivce uploadApiInfoWithCaseID:[DoraemMultiMockManger sharedInstance].caseId key:[DoraemMultiMockManger sharedInstance].key path:path sus:^(id  _Nonnull responseObject) {
        
        
    } fail:^(NSError * _Nonnull error) {
        
    }];
}

/*
 * 获取测试用例列表
 */
+ (void)getMultiCaseListWithSus:(void(^)(id responseObject))sus
                           fail:(void(^)(NSError *error))fail  {
    
    [ZooMultiNetWorkSerivce getCaseListWithSus:^(id  _Nonnull responseObject) {
        if(sus){
            sus(responseObject);
        }
    } fail:^(NSError * _Nonnull error) {
        if(fail){
            fail(error);
        }
    }];

}

/*
 * 获取用例接口列表
 */
+ (void)getMultiCaseListWithCaseID:(NSString *)caseID key:(NSString *)key sus:(void(^)(id responseObject))sus fail:(void(^)(NSError *error))fail {
    
    [ZooMultiNetWorkSerivce getCaseApiInfoWithCaseID:caseID key:key sus:^(id  _Nonnull responseObject) {
        
        // 成功处理
        NSLog(@"responseObject === %@",responseObject);
        
        
        
    } fail:^(NSError * _Nonnull error) {
        
        // 失败处理
    }];
    
}




/*
 * 获取用例接口列表
 */
+ (void)getCaseApiListWithCaseId:(NSString *)caseId
                             sus:(void(^)(id responseObject))sus
                            fail:(void(^)(NSError *error))fail {
    
    
    [ZooMultiNetWorkSerivce getCaseApiListWithCaseId:caseId sus:^(id  _Nonnull responseObject) {
        // 成功处理
        NSLog(@"responseObject === %@",responseObject);
        
        
    } fail:^(NSError * _Nonnull error) {
        
    }];

}



/*
 * 获取用例接口列表
 */
+ (void)getMultiCaseListWithCaseID:(NSString *)caseID key:(NSString *)key {
    
    [ZooMultiNetWorkSerivce getCaseApiInfoWithCaseID:caseID key:key sus:^(id  _Nonnull responseObject) {
        
        // 成功处理
        NSLog(@"responseObject === %@",responseObject);
        
        
        
    } fail:^(NSError * _Nonnull error) {
        
        // 失败处理
    }];
    
}


/*
 *  Md5 计算
 */
+ (NSString *)encodMd5:(NSString *)input {
    
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *output =  [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    for (int i = 0; i <CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",digest[i]];
    }

    return output;
}




@end
