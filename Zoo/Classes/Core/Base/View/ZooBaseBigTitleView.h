//
//  ZooBaseBigTitleView.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import <UIKit/UIKit.h>

@protocol ZooBaseBigTitleViewDelegate <NSObject>

- (void)bigTitleCloseClick;

@end

@interface ZooBaseBigTitleView : UIView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, weak) id<ZooBaseBigTitleViewDelegate> delegate;

@end
