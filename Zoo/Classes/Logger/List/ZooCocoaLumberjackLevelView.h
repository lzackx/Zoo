//
//  ZooCocoaLumberjackLevelView.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZooCocoaLumberjackLevelViewDelegate<NSObject>

- (void)segmentSelected:(NSInteger)index;

@end

@interface ZooCocoaLumberjackLevelView : UIView

@property (nonatomic, weak) id<ZooCocoaLumberjackLevelViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
