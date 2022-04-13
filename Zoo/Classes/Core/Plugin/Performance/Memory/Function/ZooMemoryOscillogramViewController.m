//
//  ZooMemoryOscillogramViewController.m
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import "ZooMemoryOscillogramViewController.h"
#import "ZooOscillogramView.h"
#import "UIView+Zoo.h"
#import "ZooMemoryUtil.h"
#import "ZooDefine.h"
#import "ZooCacheManager.h"
#import "ZooMemoryOscillogramWindow.h"

@interface ZooMemoryOscillogramViewController ()

@end

@implementation ZooMemoryOscillogramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSString *)title{
    return ZooLocalizedString(@"内存检测");
}

- (NSString *)lowValue{
    return @"0";
}

- (NSString *)highValue{
    return [NSString stringWithFormat:@"%zi",[self deviceMemory]];
}

- (void)closeBtnClick{
    [[ZooCacheManager sharedInstance] saveMemorySwitch:NO];
    [[ZooMemoryOscillogramWindow shareInstance] hide];
}

//每一秒钟采样一次内存使用率
- (void)doSecondFunction{
    NSUInteger useMemoryForApp = [ZooMemoryUtil useMemoryForApp];
    NSUInteger totalMemoryForDevice = [self deviceMemory];
    
    // 0~totalMemoryForDevice   对应 高度0~_oscillogramView.zoo_height
    [self.oscillogramView addHeightValue:useMemoryForApp*self.oscillogramView.zoo_height/totalMemoryForDevice andTipValue:[NSString stringWithFormat:@"%zi",useMemoryForApp]];
}

- (NSUInteger)deviceMemory {
    return 1000;
}


@end
