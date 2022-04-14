//
//  ZooAlertUtil.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ZooAlertOKActionBlock)(void);
typedef void (^ZooAlertCancleActionBlock)(void);

@interface ZooAlertUtil : NSObject

+ (void)handleAlertActionWithVC:(UIViewController *)vc
                     okBlock:(ZooAlertOKActionBlock)okBlock
                      cancleBlock:(ZooAlertCancleActionBlock)cancleBlock;


+ (void)handleAlertActionWithVC:(UIViewController *)vc
                             text:(NSString *)text
                     okBlock:(ZooAlertOKActionBlock)okBlock
                      cancleBlock:(ZooAlertCancleActionBlock)cancleBlock;

+ (void)handleAlertActionWithVC:(UIViewController *)vc
                           text:(NSString *)text
                        okBlock:(ZooAlertOKActionBlock)okBlock;

+ (void)handleAlertActionWithVC:(UIViewController *)vc
                          title: (NSString *)title
                           text:(NSString *)text
                             ok:(NSString *)ok
                        okBlock:(ZooAlertOKActionBlock)okBlock;

+ (void)handleAlertActionWithVC:(UIViewController *)vc
                          title: (NSString *)title
                           text:(NSString *)text
                             ok:(NSString *)ok
                         cancel:(NSString *)cancel
                        okBlock:(ZooAlertOKActionBlock)okBlock
                    cancleBlock:(ZooAlertCancleActionBlock)cancleBlock;



@end

NS_ASSUME_NONNULL_END
