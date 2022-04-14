//
//  ZooVisualInfoWindow.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooVisualInfoWindow : UIWindow
/** 显示的文本 */
@property (nonatomic, copy) NSString *infoText;
/** 显示的属性文本 */
@property (nonatomic, copy) NSAttributedString *infoAttributedText;
@end

NS_ASSUME_NONNULL_END
