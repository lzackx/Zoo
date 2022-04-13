//
//  ZooMockHalfButton.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

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


