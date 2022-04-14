//
//  ZooBaseViewController.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.
//

#import <UIKit/UIKit.h>
#import "ZooBaseBigTitleView.h"

@interface ZooBaseViewController : UIViewController

//是否需要大标题，默认不需要
- (BOOL)needBigTitleView;
@property (nonatomic, strong) ZooBaseBigTitleView *bigTitleView;

- (void)setLeftNavBarItems:(NSArray *)items;
- (void)leftNavBackClick:(id)clickView;
- (void)setRightNavTitle:(NSString *)title;
- (void)rightNavTitleClick:(id)clickView;
- (void)setRightNavBarItems:(NSArray *)items;

@end
