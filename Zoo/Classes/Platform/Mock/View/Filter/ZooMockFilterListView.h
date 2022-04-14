//
//  ZooMockDropdownListView.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import <UIKit/UIKit.h>

@protocol ZooMockFilterBgroundDelegate<NSObject>

- (void)filterBgroundClick;
- (void)filterSelectedClick;

@end

@interface ZooMockFilterListView : UIView

@property (nonatomic, weak) id<ZooMockFilterBgroundDelegate> delegate;

@property (nonatomic, assign) NSInteger selectedIndex;

- (void)showList:(NSArray *)itemArray;

- (void)closeList;

@end


