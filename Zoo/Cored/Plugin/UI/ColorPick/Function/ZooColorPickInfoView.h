//
//  ZooColorPickInfoView.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZooColorPickInfoView;

@protocol ZooColorPickInfoViewDelegate <NSObject>

@optional

- (void)closeBtnClicked:(id)sender onColorPickInfoView:(ZooColorPickInfoView *)colorPickInfoView;

@end

@interface ZooColorPickInfoView : UIView

@property (nonatomic, weak) id<ZooColorPickInfoViewDelegate> delegate;

- (void)setCurrentColor:(NSString *)hexColor;

@end

NS_ASSUME_NONNULL_END
