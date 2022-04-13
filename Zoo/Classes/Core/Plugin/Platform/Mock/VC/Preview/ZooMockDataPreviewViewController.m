//
//  ZooMockDataPreviewViewController.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooMockDataPreviewViewController.h"
#import "ZooMockManager.h"
#import "ZooDefine.h"

@interface ZooMockDataPreviewViewController ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation ZooMockDataPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"数据预览";
    CGFloat upLoadBtnHeight = kZooSizeFrom750_Landscape(100);
    CGFloat tabBarHeight = self.tabBarController.tabBar.zoo_height;
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, IPHONE_NAVIGATIONBAR_HEIGHT, self.view.zoo_width, self.view.zoo_height-IPHONE_NAVIGATIONBAR_HEIGHT-tabBarHeight-upLoadBtnHeight)];
    _textView.text = self.upLoadModel.result;
    [self.view addSubview:_textView];
    
    UIButton *upLoadBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, _textView.zoo_bottom, self.view.zoo_width, upLoadBtnHeight)];
    upLoadBtn.backgroundColor = [UIColor zoo_blue];
    [upLoadBtn setTitle:ZooLocalizedString(@"上传模版") forState:UIControlStateNormal];
    [upLoadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [upLoadBtn addTarget:self action:@selector(upload) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:upLoadBtn];
}

- (void)upload{
    [[ZooMockManager sharedInstance] uploadSaveData:self.upLoadModel atView:self.view];
}

@end
