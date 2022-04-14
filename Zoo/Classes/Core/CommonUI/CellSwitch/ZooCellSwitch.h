//
//  ZooSwitchView.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <UIKit/UIKit.h>

@protocol ZooSwitchViewDelegate<NSObject>

- (void)changeSwitchOn:(BOOL)on sender:(id)sender;

@end

@interface ZooCellSwitch : UIView

@property (nonatomic, weak) id<ZooSwitchViewDelegate> delegate;

@property (nonatomic, strong) UISwitch *switchView;

- (void)renderUIWithTitle:(NSString *)title switchOn:(BOOL)on;

- (void)needTopLine;

- (void)needDownLine;

@end
