//
//  ZooUIProfileWindow.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooUIProfileWindow : UIWindow

+ (instancetype)sharedInstance;
- (void)showWithDepthText:(NSString *)text
               detailInfo:(NSString *)detail;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
