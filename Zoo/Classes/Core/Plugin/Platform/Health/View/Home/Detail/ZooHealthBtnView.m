//
//  ZooHealthBtnView.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooHealthBtnView.h"
#import "ZooHealthManager.h"
#import "ZooDefine.h"

@interface ZooHealthBtnView()

@property (nonatomic, strong) UIImageView *healthBtn;

@end

@implementation ZooHealthBtnView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _healthBtn = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.zoo_width, self.zoo_height)];
        [_healthBtn setImage:[UIImage zoo_xcassetImageNamed:@"zoo_health_start"]];
        [self addSubview:_healthBtn];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tap{
    if (_delegate && [_delegate respondsToSelector:@selector(healthBtnClick:)]) {
        [_delegate healthBtnClick:self];
    }
}

- (void)statusForBtn:(BOOL)start{
    NSString *imgName = @"zoo_health_start";
    if(start){
        imgName = @"zoo_health_end";
    }
    [_healthBtn setImage:[UIImage zoo_xcassetImageNamed:imgName]];
}


@end
