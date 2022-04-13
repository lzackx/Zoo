//
//  ZooQRCodeViewController.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import <Foundation/Foundation.h>
#import "ZooBaseViewController.h"

@interface ZooQRCodeViewController : ZooBaseViewController
@property (nonatomic, copy) void(^QRCodeBlock)(NSString *QRCodeResult);
@end

