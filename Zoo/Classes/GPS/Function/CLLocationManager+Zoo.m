//
//  CLLocationManager+Zoo.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "CLLocationManager+Zoo.h"
#import "ZooGPSMocker.h"
#import <objc/runtime.h>

@implementation CLLocationManager (Zoo)

- (void)zoo_swizzleLocationDelegate:(id)delegate {
    if (delegate) {
        [self zoo_swizzleLocationDelegate:[ZooGPSMocker shareInstance]];
        [[ZooGPSMocker shareInstance] addLocationBinder:self delegate:delegate];
        
        Protocol *proto = objc_getProtocol("CLLocationManagerDelegate");
        unsigned int count;
        struct objc_method_description *methods = protocol_copyMethodDescriptionList(proto, NO, YES, &count);
        for(unsigned i = 0; i < count; i++)
        {
            SEL sel = methods[i].name;
            if ([delegate respondsToSelector:sel]) {
                if (![[ZooGPSMocker shareInstance] respondsToSelector:sel]) {
                    NSAssert(NO, @"Delegate : %@ not implementation SEL : %@",delegate,NSStringFromSelector(sel));

                }
            }
        }
        free(methods);
        
    }else{
        [self zoo_swizzleLocationDelegate:delegate];
    }
}

@end
