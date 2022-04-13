//
//  ZooMockBaseViewController.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooBaseViewController.h"
#import "ZooMockFilterListView.h"
#import "ZooMockFilterButton.h"
#import "ZooMockSearchView.h"

@interface ZooMockBaseViewController : ZooBaseViewController

@property (nonatomic, strong) ZooMockSearchView *searchView;
@property (nonatomic, strong) UIView *sepeatorLine;
@property (nonatomic, strong) ZooMockFilterListView *listView;
@property (nonatomic, strong) ZooMockFilterButton *leftButton;
@property (nonatomic, strong) ZooMockFilterButton *rightButton;

- (void)filterSelectedClick;

@end

