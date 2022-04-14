//
//  ZooHealthHomeView.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooHealthHomeView.h"
#import "ZooHealthBgView.h"
#import "ZooHealthManager.h"
#import "ZooToastUtil.h"
#import "ZooDefine.h"
#import "ZooHealthManager.h"

@interface ZooHealthHomeView ()<ZooHealthButtonDelegate>

@property (nonatomic, strong) ZooHealthBgView *bgView;
@property (nonatomic, copy) ZooHealthHomeBlock block;

@end

@implementation ZooHealthHomeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _bgView = [[ZooHealthBgView alloc] initWithFrame:CGRectMake(0, 0, self.zoo_width, self.zoo_height)];
        _startingTitle = [[ZooHealthStartingTitle alloc] initWithFrame:[_bgView getStartingTitleCGRect]];
        if ([ZooHealthManager sharedInstance].start) {
            [_startingTitle renderUIWithTitle:ZooLocalizedString(@"正在检测中...")];
        }else{
            [_startingTitle renderUIWithTitle:ZooLocalizedString(@"点击开始检测")];
        }
        
        _btnView = [[ZooHealthBtnView alloc] initWithFrame:[_bgView getButtonCGRect]];
        [_btnView statusForBtn:[ZooHealthManager sharedInstance].start];
        _btnView.delegate = self;
        
        [self addSubview:_bgView];
        [self addSubview:_startingTitle];
        [self addSubview:_btnView];
    }
    return self;
}

- (void)addBlock:(ZooHealthHomeBlock)block{
    self.block = block;
}

- (void)_selfHandle{
    if(self.block){
        self.block();
    }
}

#pragma mark - ZooHealthButtonDelegate
- (void)healthBtnClick:(nonnull id)sender {
    [self _selfHandle];
}

@end
