//
//  ZooNSLogSearchView.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZooNSLogSearchViewDelegate  <NSObject>

- (void)searchViewInputChange:(NSString *)text;

@end

@interface ZooNSLogSearchView : UIView

@property (nonatomic, weak) id<ZooNSLogSearchViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
