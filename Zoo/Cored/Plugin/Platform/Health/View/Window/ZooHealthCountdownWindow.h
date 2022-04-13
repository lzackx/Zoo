//
//  ZooHealthCountdownWindow.h
//  ZooKit
//
//  Created by lZackx on 04/12/2022 
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooHealthCountdownWindow : UIWindow


+ (ZooHealthCountdownWindow *)shareInstance;

- (void)start:(NSInteger)number;
- (void)hide;
- (NSInteger)getCountdown;

@end

NS_ASSUME_NONNULL_END
