//
//  ZooHealthViewController.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooHealthViewController.h"
#import "ZooHealthHomeView.h"
#import "ZooHealthFooterView.h"
#import "ZooHealthManager.h"
#import "ZooHealthAlertView.h"
#import "ZooHealthInstructionsView.h"
#import "ZooDefine.h"

@interface ZooHealthViewController()<UIScrollViewDelegate,ZooHealthFooterButtonDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ZooHealthHomeView *homeView;
@property (nonatomic, strong) ZooHealthInstructionsView *instructionsView;
@property (nonatomic, strong) ZooHealthFooterView *footerView;

@end

@implementation ZooHealthViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = ZooLocalizedString(@"健康体检");
    CGFloat offset_y = self.bigTitleView.zoo_bottom;
    _homeView = [[ZooHealthHomeView alloc] initWithFrame:CGRectMake(0, 0, self.view.zoo_width, self.view.zoo_height - offset_y)];
    
    _instructionsView = [[ZooHealthInstructionsView alloc] initWithFrame:CGRectMake(0, _homeView.zoo_bottom, self.view.zoo_width, self.view.zoo_height - offset_y)];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, offset_y, self.view.zoo_width, self.view.zoo_height - offset_y)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(_homeView.zoo_width, _homeView.zoo_height*2);//设置大小
    _scrollView.pagingEnabled = YES;
    
    CGFloat footerHeight = kZooSizeFrom750_Landscape(145);
    CGFloat footerTop = self.view.zoo_height - footerHeight;
    if (@available(iOS 11.0, *)) {
        footerTop -= self.view.safeAreaInsets.bottom;
    }
    _footerView = [[ZooHealthFooterView alloc] initWithFrame:CGRectMake(0, footerTop, self.view.zoo_width, footerHeight)];
    _footerView.delegate = self;
    [_footerView renderUIWithTitleImg:YES];
    
    
    __weak typeof(self) weakSelf = self;
    [_homeView addBlock:^{
        BOOL currentStatus = [ZooHealthManager sharedInstance].start;
        if (currentStatus) {
            [self showFooter:YES];
            [self.homeView.btnView statusForBtn:NO];
            [self.homeView.startingTitle renderUIWithTitle:ZooLocalizedString(@"点击开始检测")];
            [[ZooHealthManager sharedInstance] stopHealthCheck];
        }else{
            [ZooAlertUtil handleAlertActionWithVC:weakSelf text:@"是否重启App开启健康体检" okBlock:^{
                [[ZooHealthManager sharedInstance] rebootAppForHealthCheck];
            } cancleBlock:^{}];
            
        }
    }];
    
    [_scrollView addSubview:_homeView];
    [_scrollView addSubview:_instructionsView];
    [self.view addSubview:_scrollView];
    [self.view addSubview:_footerView];
    
    [self showFooter:![ZooHealthManager sharedInstance].start];
    
}

- (BOOL)needBigTitleView{
    return YES;
}

- (void)showFooter:(BOOL)show{
    _footerView.hidden = !show;
    _scrollView.scrollEnabled = show;
}


#pragma mark - ZooHealthFooterButtonDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
    if (scrollToScrollStop) {
        [_footerView renderUIWithTitleImg: scrollView.contentOffset.y <= 0];
        _footerView.hidden = NO;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _footerView.hidden = YES;
}

#pragma mark - ZooHealthFooterButtonDelegate
- (void)footerBtnClick:(id)sender{
    if(_footerView.top){
        _scrollView.contentOffset = CGPointMake(0, _scrollView.zoo_height);
    }else{
        _scrollView.contentOffset = CGPointMake(0, 0);
    }
    [_footerView renderUIWithTitleImg:!_footerView.top];
    _footerView.hidden = NO;
}


@end
