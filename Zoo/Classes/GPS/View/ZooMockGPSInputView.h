//
//  ZooMockGPSInputView.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <UIKit/UIKit.h>

@protocol ZooMockGPSInputViewDelegate <NSObject>

- (void)inputViewOkClick:(NSString *)gps;

@end

@interface ZooMockGPSInputView : UIView

@property (nonatomic, weak) id<ZooMockGPSInputViewDelegate> delegate;

@end

