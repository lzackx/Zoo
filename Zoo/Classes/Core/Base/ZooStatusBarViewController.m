//
//  ZooStatusBarViewController.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooStatusBarViewController.h"
#import "ZooManager.h"

@interface ZooStatusBarViewController ()

@end

@implementation ZooStatusBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// iOS9.0的系统中，新建的window设置的rootViewController默认没有显示状态栏

#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_9_3

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#endif

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return ZooManager.shareInstance.supportedInterfaceOrientations;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
