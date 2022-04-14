//
//  ZooMLeaksFinderDetailViewController.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooMLeaksFinderDetailViewController.h"
#import "ZooDefine.h"

@interface ZooMLeaksFinderDetailViewController ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation ZooMLeaksFinderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = ZooLocalizedString(@"内存泄漏详情");
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.textColor = [UIColor zoo_black_2];
    _contentLabel.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(16)];
    _contentLabel.numberOfLines = 0;
    _contentLabel.text = [_info description];
    
    CGSize fontSize = [_contentLabel sizeThatFits:CGSizeMake(self.view.zoo_width-40, MAXFLOAT)];
    _contentLabel.frame = CGRectMake(20, IPHONE_NAVIGATIONBAR_HEIGHT, fontSize.width, fontSize.height);
    [self.view addSubview:_contentLabel];
}


@end
