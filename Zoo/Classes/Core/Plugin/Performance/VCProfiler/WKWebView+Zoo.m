//
//  WKWebView+Zoo.m
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import "WKWebView+Zoo.h"
#import <objc/runtime.h>
#import "NSObject+Zoo.h"
#import "ZooHealthManager.h"

@implementation WKWebView (Zoo)

+ (void)load{
    [self zoo_swizzleInstanceMethodWithOriginSel:@selector(loadRequest:) swizzledSel:@selector(zoo_loadRequest:)];
}

- (WKNavigation *)zoo_loadRequest:(NSURLRequest *)request{
    WKNavigation *navigation = [self zoo_loadRequest:request];
    NSString *urlString = request.URL.absoluteString;
    [[ZooHealthManager sharedInstance] openH5Page:urlString];
    return navigation;
}

@end
