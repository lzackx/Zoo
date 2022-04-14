//
//  ZooGPSMocker.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

//参考wander
@interface ZooGPSMocker : NSObject

+ (ZooGPSMocker *)shareInstance;

- (void)addLocationBinder:(id)binder delegate:(id)delegate;

- (BOOL)mockPoint:(CLLocation*)location;

- (void)stopMockPoint;

@property (nonatomic, assign) BOOL isMocking;

@end
