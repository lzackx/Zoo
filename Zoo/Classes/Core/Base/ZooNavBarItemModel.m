//
//  ZooNavBarItemModel.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooNavBarItemModel.h"

@implementation ZooNavBarItemModel

- (instancetype)initWithText:(NSString *)text color:(UIColor *)color selector:(SEL)selector{
    self = [[ZooNavBarItemModel alloc] init];
    self.type = ZooNavBarItemTypeText;
    self.text = text;
    self.textColor = color;
    self.selector = selector;
    return self;
}
- (instancetype)initWithImage:(UIImage *)image selector:(SEL)selector{
    self = [[ZooNavBarItemModel alloc] init];
    self.type = ZooNavBarItemTypeImage;
    self.image = image;
    self.selector = selector;
    return self;
}

@end
