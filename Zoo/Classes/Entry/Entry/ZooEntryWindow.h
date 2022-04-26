//
//  ZooEntryWindow.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.  
//

#import <UIKit/UIKit.h>

/// 入口滑动浮窗（默认记录上次坐标）
@interface ZooEntryWindow : UIWindow

/// 是否自动停靠，默认为YES
@property (nonatomic, assign) BOOL autoDock;

// 定制位置
- (instancetype)initWithStartPoint:(CGPoint)startingPosition;

- (void)configEntryBtnBlingWithText:(NSString *)text backColor:(UIColor *)backColor;
@end
