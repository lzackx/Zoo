//
//  ZooMockHalfButton.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <UIKit/UIKit.h>

@protocol ZooMockFilterButtonDelegate<NSObject>

- (void)filterBtnClick:(id)sender;

@end

@interface ZooMockFilterButton : UIView

@property (nonatomic, weak) id<ZooMockFilterButtonDelegate> delegate;

@property (nonatomic, assign) BOOL down;
@property (nonatomic, assign) NSInteger selectedItemIndex;

- (void)renderUIWithTitle:(NSString *)title;
- (void)setDropdown:(BOOL )isDown;

@end


