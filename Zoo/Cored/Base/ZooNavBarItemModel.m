//
//  ZooNavBarItemModel.m
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

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
