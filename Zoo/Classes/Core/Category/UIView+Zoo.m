//
//  UIView+Zoo.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "UIView+Zoo.h"

#define Zoo_SCREEN_SCALE                    ([[UIScreen mainScreen] scale])
#define Zoo_PIXEL_INTEGRAL(pointValue)      (round(pointValue * Zoo_SCREEN_SCALE) / Zoo_SCREEN_SCALE)

@implementation UIView (Zoo)

@dynamic zoo_x, zoo_y, zoo_width, zoo_height, zoo_origin, zoo_size;

// Setters
-(void)setZoo_x:(CGFloat)x{
    self.frame      = CGRectMake(Zoo_PIXEL_INTEGRAL(x), self.zoo_y, self.zoo_width, self.zoo_height);
}

-(void)setZoo_y:(CGFloat)y{
    self.frame      = CGRectMake(self.zoo_x, Zoo_PIXEL_INTEGRAL(y), self.zoo_width, self.zoo_height);
}

-(void)setZoo_width:(CGFloat)width{
    self.frame      = CGRectMake(self.zoo_x, self.zoo_y, Zoo_PIXEL_INTEGRAL(width), self.zoo_height);
}

-(void)setZoo_height:(CGFloat)height{
    self.frame      = CGRectMake(self.zoo_x, self.zoo_y, self.zoo_width, Zoo_PIXEL_INTEGRAL(height));
}

-(void)setZoo_origin:(CGPoint)origin{
    self.zoo_x          = origin.x;
    self.zoo_y          = origin.y;
}

-(void)setZoo_size:(CGSize)size{
    self.zoo_width      = size.width;
    self.zoo_height     = size.height;
}

-(void)setZoo_right:(CGFloat)right {
    self.zoo_x          = right - self.zoo_width;
}

-(void)setZoo_bottom:(CGFloat)bottom {
    self.zoo_y          = bottom - self.zoo_height;
}

-(void)setZoo_left:(CGFloat)left{
    self.zoo_x          = left;
}

-(void)setZoo_top:(CGFloat)top{
    self.zoo_y          = top;
}

-(void)setZoo_centerX:(CGFloat)centerX {
    self.center     = CGPointMake(Zoo_PIXEL_INTEGRAL(centerX), self.center.y);
}

-(void)setZoo_centerY:(CGFloat)centerY {
    self.center     = CGPointMake(self.center.x, Zoo_PIXEL_INTEGRAL(centerY));
}

// Getters
-(CGFloat)zoo_x{
    return self.frame.origin.x;
}

-(CGFloat)zoo_y{
    return self.frame.origin.y;
}

-(CGFloat)zoo_width{
    return self.frame.size.width;
}

-(CGFloat)zoo_height{
    return self.frame.size.height;
}

-(CGPoint)zoo_origin{
    return CGPointMake(self.zoo_x, self.zoo_y);
}

-(CGSize)zoo_size{
    return CGSizeMake(self.zoo_width, self.zoo_height);
}

-(CGFloat)zoo_right {
    return self.frame.origin.x + self.frame.size.width;
}

-(CGFloat)zoo_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

-(CGFloat)zoo_left{
    return self.zoo_x;
}

-(CGFloat)zoo_top{
    return self.zoo_y;
}

-(CGFloat)zoo_centerX {
    return self.center.x;
}

-(CGFloat)zoo_centerY {
    return self.center.y;
}

-(UIViewController *)zoo_viewController{
    for(UIView *next =self.superview ; next ; next = next.superview){
        UIResponder*nextResponder = [next nextResponder];
        if([nextResponder isKindOfClass:[UIViewController class]]){
            return(UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
