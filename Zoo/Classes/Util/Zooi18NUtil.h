//
//  Zooi18NUtil.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <Foundation/Foundation.h>

#define ZooLocalizedString(key)   [Zooi18NUtil localizedString:key]

@interface Zooi18NUtil : NSObject

+ (NSString *)localizedString:(NSString *)key;

@end

