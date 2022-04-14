//
//  ZooHealthBtnView.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZooHealthButtonDelegate<NSObject>

- (void)healthBtnClick:(id)sender;

@end

@interface ZooHealthBtnView : UIView

@property (nonatomic, weak) id<ZooHealthButtonDelegate> delegate;

- (void)statusForBtn:(BOOL)start;

@end

NS_ASSUME_NONNULL_END
