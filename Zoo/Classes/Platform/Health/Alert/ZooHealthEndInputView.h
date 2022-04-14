//
//  ZooHealthEndInputView.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooHealthEndInputView : UIView

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textField;

- (void)renderUIWithTitle:(NSString *)tip placeholder:(NSString *)placeholder;

@end

NS_ASSUME_NONNULL_END
