//
//  Zooi18NUtil.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <Foundation/Foundation.h>

#define ZooLocalizedString(key)   [Zooi18NUtil localizedString:key]

@interface Zooi18NUtil : NSObject

+ (NSString *)localizedString:(NSString *)key;

@end

