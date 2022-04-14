//
//  ZooMockGPSCenterView.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <UIKit/UIKit.h>


@interface ZooMockGPSCenterView : UIView

- (void)renderUIWithGPS:(NSString *)gps;

- (void)hiddenGPSInfo:(BOOL)hidden;

@end

