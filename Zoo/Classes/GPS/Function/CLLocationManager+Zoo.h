//
//  CLLocationManager+Zoo.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <CoreLocation/CoreLocation.h>

//参考wander
@interface CLLocationManager (Zoo)

- (void)zoo_swizzleLocationDelegate:(id)delegate;

@end
