//
//  ZooMockDropdownListView.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

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


