//
//  ZooColorPickInfoWindow.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooColorPickInfoWindow : UIWindow

+ (ZooColorPickInfoWindow *)shareInstance;

- (void)show;

- (void)hide;

- (void)setCurrentColor:(NSString *)hexColor;

@end

NS_ASSUME_NONNULL_END
