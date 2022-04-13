//
//  ZooMockSearchView.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZooMockSearchViewDelegate  <NSObject>

- (void)searchViewInputChange:(NSString *)text;

@end

@interface ZooMockSearchView : UIView

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, weak) id<ZooMockSearchViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
