//
//  UIView+Zoo.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <UIKit/UIKit.h>

@interface UIView (Zoo)

/** View's X Position */
@property (nonatomic, assign) CGFloat   zoo_x;

/** View's Y Position */
@property (nonatomic, assign) CGFloat   zoo_y;

/** View's width */
@property (nonatomic, assign) CGFloat   zoo_width;

/** View's height */
@property (nonatomic, assign) CGFloat   zoo_height;

/** View's origin - Sets X and Y Positions */
@property (nonatomic, assign) CGPoint   zoo_origin;

/** View's size - Sets Width and Height */
@property (nonatomic, assign) CGSize    zoo_size;

/** Y value representing the bottom of the view **/
@property (nonatomic, assign) CGFloat   zoo_bottom;

/** X Value representing the right side of the view **/
@property (nonatomic, assign) CGFloat   zoo_right;

/** X Value representing the top of the view (alias of x) **/
@property (nonatomic, assign) CGFloat   zoo_left;

/** Y Value representing the top of the view (alias of y) **/
@property (nonatomic, assign) CGFloat   zoo_top;

/** X value of the object's center **/
@property (nonatomic, assign) CGFloat   zoo_centerX;

/** Y value of the object's center **/
@property (nonatomic, assign) CGFloat   zoo_centerY;

- (UIViewController *)zoo_viewController;

@end

