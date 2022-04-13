//
//  ZooPluginProtocol.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import <Foundation/Foundation.h>

@protocol ZooPluginProtocol <NSObject>

@optional
- (void)pluginDidLoad;
- (void)pluginDidLoad:(NSDictionary *)itemData;

@end
