//
//  ZooPluginProtocol.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <Foundation/Foundation.h>

@protocol ZooPluginProtocol <NSObject>

@optional
- (void)pluginDidLoad;
- (void)pluginDidLoad:(NSDictionary *)itemData;

@end
