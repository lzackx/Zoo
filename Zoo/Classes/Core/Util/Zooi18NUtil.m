//
//  Zooi18NUtil.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "Zooi18NUtil.h"

@implementation Zooi18NUtil

+ (NSString *)localizedString:(NSString *)key {
    
    NSString *language = [[NSLocale preferredLanguages] firstObject];
    if (language.length == 0) {
        return key;
    }
    NSString *fileNamePrefix = @"zh-Hans";
    if([language hasPrefix:@"en"]) {
        fileNamePrefix = @"en";
    }
//    NSBundle *tmp = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle/", @"Zoo"]]];
    NSBundle *tmpBundle = [NSBundle bundleForClass:NSClassFromString(@"ZooManager")];
    NSURL *url = [tmpBundle URLForResource:@"Zoo" withExtension:@"bundle"];
    if(!url) return key;
    NSBundle *tmp = [NSBundle bundleWithURL:url];
    
    NSString *path = [tmp pathForResource:fileNamePrefix ofType:@"lproj"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    NSString *localizedString = [bundle localizedStringForKey:key value:nil table:@"Zoo"];
    if (!localizedString) {
        localizedString = key;
    }
    return localizedString;
}

@end
