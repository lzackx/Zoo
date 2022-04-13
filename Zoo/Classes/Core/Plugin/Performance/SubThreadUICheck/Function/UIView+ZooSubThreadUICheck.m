//
//  UIView+Zoo.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "UIView+Zoo.h"
#import "NSObject+Zoo.h"
#import "ZooCacheManager.h"
#import "ZooSubThreadUICheckManager.h"
#import "ZooUtil.h"
#import "ZooHealthManager.h"
#import "ZooBacktraceLogger.h"

@implementation UIView (ZooSubThreadUICheck)

+ (void)load{
    if ([NSStringFromClass([self class]) isEqualToString:@"UIView"]) {
        [[self  class] zoo_swizzleInstanceMethodWithOriginSel:@selector(setNeedsLayout) swizzledSel:@selector(zoo_setNeedsLayout)];
        [[self class] zoo_swizzleInstanceMethodWithOriginSel:@selector(setNeedsDisplay) swizzledSel:@selector(zoo_setNeedsDisplay)];
        [[self class] zoo_swizzleInstanceMethodWithOriginSel:@selector(setNeedsDisplayInRect:) swizzledSel:@selector(zoo_setNeedsDisplayInRect:)];
    }
}

- (void)zoo_setNeedsLayout{
    [self zoo_setNeedsLayout];
    [self uiCheck];
}

- (void)zoo_setNeedsDisplay{
    [self zoo_setNeedsDisplay];
    [self uiCheck];
}

- (void)zoo_setNeedsDisplayInRect:(CGRect)rect{
    [self zoo_setNeedsDisplayInRect:rect];
    [self uiCheck];
}

- (void)uiCheck{
    if(![NSThread isMainThread]){
        if ([[ZooCacheManager sharedInstance] subThreadUICheckSwitch]) {
            NSString *report = [ZooBacktraceLogger zoo_backtraceOfCurrentThread];
            NSDictionary *dic = @{
                                  @"title":[ZooUtil dateFormatNow],
                                  @"content":report
                                  };
            [[ZooSubThreadUICheckManager sharedInstance].checkArray addObject:dic];
            [[ZooHealthManager sharedInstance] addSubThreadUI:dic];
        }
    }
}

@end
