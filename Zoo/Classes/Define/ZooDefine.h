//
//  ZooDefine.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.  
//

#ifndef ZooDefine_h
#define ZooDefine_h

#import "ZooAppInfoUtil.h"
#import "UIColor+Zoo.h"
#import "UIView+Zoo.h"
#import "UIImage+Zoo.h"
#import "Zooi18NUtil.h"
#import "ZooToastUtil.h"
#import "ZooAlertUtil.h"
#import "ZooUtil.h"

#define ZooVersion [[[NSBundle bundleForClass:[ZooManager class]] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define ZooKbChange(x) x * 1000

#ifdef Zoo_OpenLog
#define ZooLog(...) NSLog(@"ZooLog -> %s\n %@ \n\n",__func__,[NSString stringWithFormat:__VA_ARGS__]);
#else
#define ZooLog(...)
#endif

#define WEAKSELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define ZooScreenWidth [UIScreen mainScreen].bounds.size.width
#define ZooScreenHeight [UIScreen mainScreen].bounds.size.height

//Zoo默认位置
#define ZooStartingPosition            CGPointMake(0, ZooScreenHeight/3.0)

//Zoo全屏默认位置
#define ZooFullScreenStartingPosition  CGPointZero

//根据750*1334分辨率计算size
#define kZooSizeFrom750(x) ((x)*ZooScreenWidth/750)
// 如果横屏显示
#define kZooSizeFrom750_Landscape(x) (kInterfaceOrientationLandscape ? ((x)*ZooScreenHeight/750) : kZooSizeFrom750(x))

#define kInterfaceOrientationPortrait UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)

#define kInterfaceOrientationLandscape UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)


#define IS_IPHONE_X_Series [ZooAppInfoUtil isIPhoneXSeries]
#define IPHONE_NAVIGATIONBAR_HEIGHT  (IS_IPHONE_X_Series ? 88 : 64)
#define IPHONE_STATUSBAR_HEIGHT      (IS_IPHONE_X_Series ? 44 : 20)
#define IPHONE_SAFEBOTTOMAREA_HEIGHT (IS_IPHONE_X_Series ? 34 : 0)
#define IPHONE_TOPSENSOR_HEIGHT      (IS_IPHONE_X_Series ? 32 : 0)

//判空
#define STRING_IS_BLANK(str) (str==nil ||![str isKindOfClass:[NSString class]]|| [str length]<1)
#define STRING_NOT_NULL(str) ((str==nil)?@"":str)
#define DICTIONARY_IS_EMPTY(dic) ((dic)==nil || ![(dic) isKindOfClass:[NSDictionary class]] || (dic).count < 1)
#define ARRAY_IS_NULL(array) ((array)==nil || ![(array) isKindOfClass:[NSArray class]] || ([array count]) < 1)
#define ARRAY_IS_EMPTY(array) ((array)==nil || ![(array) isKindOfClass:[NSArray class]] || (array).count < 1)
#define STRING_DEFAULT_BLANK(str) ((str==nil)?@"":str)


#define ZooClosePluginNotification @"ZooClosePluginNotification"
#define ZooQuickOpenLogVCNotification @"ZooQuickOpenLogVCNotification"
#define ZooManagerUpdateNotification @"ZooManagerUpdateNotification"


#endif /* ZooDefine_h */
