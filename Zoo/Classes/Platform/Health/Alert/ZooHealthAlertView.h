//
//  ZooHealthAlertView.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ZooHealthAlertOKActionBlock)(void);
typedef void (^ZooHealthAlertCancleActionBlock)(void);
typedef void (^ZooHealthAlertQuitActionBlock)(void);

@interface ZooHealthAlertView : UIView

- (void)renderUI:(NSString *)title placeholder:(NSArray*)placeholders inputTip:(NSArray*)inputTips ok:(NSString *)okText quit:(NSString *)quitText cancle:(NSString *)cancleText  okBlock:(ZooHealthAlertOKActionBlock)okBlock quitBlock:(ZooHealthAlertQuitActionBlock) quitBlock
cancleBlock:(ZooHealthAlertCancleActionBlock)cancleBlock ;

- (NSArray *)getInputText;

@end

NS_ASSUME_NONNULL_END
