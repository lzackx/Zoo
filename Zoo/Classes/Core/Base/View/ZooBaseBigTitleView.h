//
//  ZooBaseBigTitleView.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <UIKit/UIKit.h>

@protocol ZooBaseBigTitleViewDelegate <NSObject>

- (void)bigTitleCloseClick;

@end

@interface ZooBaseBigTitleView : UIView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, weak) id<ZooBaseBigTitleViewDelegate> delegate;

@end
