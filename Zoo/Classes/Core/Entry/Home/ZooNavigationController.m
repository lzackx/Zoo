//
//  ZooNavigationController.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.  Copyright © 2020 YunXIao. All rights reserved.
//

#import "ZooNavigationController.h"
#import "ZooManager.h"

@interface ZooNavigationController ()

@end

@implementation ZooNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

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
