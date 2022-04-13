//
//  ZooOscillogramViewController.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import <UIKit/UIKit.h>
#import "ZooOscillogramView.h"

@interface ZooOscillogramViewController : UIViewController

@property (nonatomic, strong) ZooOscillogramView *oscillogramView;
@property (nonatomic, strong) UIButton *closeBtn;

- (NSString *)title;
- (NSString *)lowValue;
- (NSString *)highValue;
- (void)closeBtnClick;
- (void)startRecord;
- (void)endRecord;
- (void)doSecondFunction;

@end
