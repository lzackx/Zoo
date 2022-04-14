//
//  ZooNavBarItemModel.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZooNavBarItemType) {
    ZooNavBarItemTypeText = 0,
    ZooNavBarItemTypeImage,
};

@interface ZooNavBarItemModel : NSObject

@property (nonatomic, assign) ZooNavBarItemType type;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) SEL selector;

- (instancetype)initWithText:(NSString *)text color:(UIColor *)color selector:(SEL)selector;
- (instancetype)initWithImage:(UIImage *)image selector:(SEL)selector;

@end
