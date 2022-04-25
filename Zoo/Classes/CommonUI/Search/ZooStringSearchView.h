//
//  ZooNSLogSearchView.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZooStringSearchViewDelegate  <NSObject>

- (void)searchViewInputChange:(NSString *)text;

@end

@interface ZooStringSearchView : UIView

@property (nonatomic, weak) id<ZooStringSearchViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
