//
//  ZooMockDetailButton.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <UIKit/UIKit.h>

@protocol ZooMockSceneButtonDelegate<NSObject>

- (void)sceneBtnClick:(NSInteger)tag;

@end

@interface ZooMockSceneButton : UIView

@property (nonatomic, weak) id<ZooMockSceneButtonDelegate> delegate;

@property (nonatomic, assign) BOOL isSelected;

- (void) renderTitle:(NSString *)title  isSelected:(BOOL)select;

- (void) didSelected;

- (void) cancelSelected;

+ (CGFloat)viewWidth:(NSString *)sceneName;

@end

