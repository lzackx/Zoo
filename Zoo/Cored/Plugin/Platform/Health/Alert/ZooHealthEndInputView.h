//
//  ZooHealthEndInputView.h
//  ZooKit
//
//  Created by lZackx on 04/12/2022 
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooHealthEndInputView : UIView

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textField;

- (void)renderUIWithTitle:(NSString *)tip placeholder:(NSString *)placeholder;

@end

NS_ASSUME_NONNULL_END
