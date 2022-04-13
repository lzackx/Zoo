//
//  ZooHealthAlertView.h
//  ZooKit
//
//  Created by lZackx on 04/12/2022 
//

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
