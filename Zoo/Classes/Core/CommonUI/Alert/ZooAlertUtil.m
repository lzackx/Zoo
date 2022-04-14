//
//  ZooAlertUtil.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooAlertUtil.h"
#import "Zooi18NUtil.h"

@implementation ZooAlertUtil

+ (void)handleAlertActionWithVC:(UIViewController *)vc
                        okBlock:(ZooAlertOKActionBlock)okBlock
                    cancleBlock:(ZooAlertCancleActionBlock)cancleBlock {
    [self handleAlertActionWithVC:vc text:ZooLocalizedString(@"该功能需要重启App才能生效") okBlock:okBlock cancleBlock:cancleBlock];
}


+ (void)handleAlertActionWithVC:(UIViewController *)vc
                           text:(NSString *)text
                        okBlock:(ZooAlertOKActionBlock)okBlock
                    cancleBlock:(ZooAlertCancleActionBlock)cancleBlock {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:ZooLocalizedString(@"提示") message:text preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:ZooLocalizedString(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancleBlock ? cancleBlock():nil;
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:ZooLocalizedString(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        okBlock ? okBlock():nil;
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [vc presentViewController:alertController animated:YES completion:nil];
}

+ (void)handleAlertActionWithVC:(UIViewController *)vc
                           text:(NSString *)text
                        okBlock:(ZooAlertOKActionBlock)okBlock{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:ZooLocalizedString(@"提示") message:text preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:ZooLocalizedString(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        okBlock ? okBlock():nil;
    }];
    [alertController addAction:okAction];
    [vc presentViewController:alertController animated:YES completion:nil];
}

+ (void)handleAlertActionWithVC:(UIViewController *)vc
                          title: (NSString *)title
                           text:(NSString *)text
                             ok:(NSString *)ok
                        okBlock:(ZooAlertOKActionBlock)okBlock{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        okBlock ? okBlock():nil;
    }];
    [alertController addAction:okAction];
    [vc presentViewController:alertController animated:YES completion:nil];
}

+ (void)handleAlertActionWithVC:(UIViewController *)vc
                          title: (NSString *)title
                           text:(NSString *)text
                             ok:(NSString *)ok
                         cancel:(NSString *)cancel
                        okBlock:(ZooAlertOKActionBlock)okBlock
                    cancleBlock:(ZooAlertCancleActionBlock)cancleBlock {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancleBlock ? cancleBlock():nil;
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        okBlock ? okBlock():nil;
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [vc presentViewController:alertController animated:YES completion:nil];
}


@end
