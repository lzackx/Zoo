//
//  ZooHealthStartingTitle.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooHealthStartingTitle.h"
#import "ZooDefine.h"

@interface ZooHealthStartingTitle()

@property (nonatomic, strong) UILabel *title;

@end

@implementation ZooHealthStartingTitle

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.zoo_width, self.zoo_height)];
        _title.textColor = [UIColor zoo_colorWithString:@"#27BCB7"];
        _title.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(28)];
        _title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_title];
    }
    return self;
}

- (void)renderUIWithTitle:(NSString *)title{
    if(title){
        _title.text = title;
    }
}

- (void)showUITitle:(BOOL)show{
    if(show){
        _title.hidden = NO;
    }else{
        _title.hidden = YES;
    }
}


@end
