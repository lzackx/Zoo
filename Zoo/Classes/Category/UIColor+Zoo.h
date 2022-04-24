//
//  UIColor+Zoo.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <UIKit/UIKit.h>

@interface UIColor (Zoo)

@property (nonatomic, readonly) CGFloat red; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat green; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat blue; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat white; // Only valid if colorSpaceModel == kCGColorSpaceModelMonochrome
@property (nonatomic, readonly) CGFloat alpha;


+ (UIColor *)zoo_colorWithHex:(UInt32)hex;
+ (UIColor *)zoo_colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;
+ (UIColor *)zoo_colorWithHexString:(NSString *)hexString;

+ (UIColor *)zoo_colorWithString:(NSString *)hexString;

+ (UIColor *)zoo_black_1;//#333333
+ (UIColor *)zoo_black_2;//#666666
+ (UIColor *)zoo_black_3;//#999999

+ (UIColor *)zoo_blue;//#337CC4

+ (UIColor *)zoo_line;//[UIColor zoo_colorWithHex:0x000000 andAlpha:0.1];

+ (UIColor *)zoo_randomColor;

+ (UIColor *)zoo_bg; //#F4F5F6

+ (UIColor *)zoo_orange; //#FF8903

@end
