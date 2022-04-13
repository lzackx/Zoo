//
//  ZooCellButton.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import <UIKit/UIKit.h>

@protocol ZooCellButtonDelegate<NSObject>

- (void)cellBtnClick:(id)sender;

@end

@interface ZooCellButton : UIView

@property (nonatomic, weak) id<ZooCellButtonDelegate> delegate;

- (void)renderUIWithTitle:(NSString *)title;

- (void)renderUIWithRightContent:(NSString *)rightContent;

- (void)needTopLine;

- (void)needDownLine;

@end
