//
//  ZooLargeImageDetectionListViewController.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <UIKit/UIKit.h>
#import "ZooBaseViewController.h"
@class ZooResponseImageModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZooLargeImageDetectionListViewController : ZooBaseViewController
- (instancetype)initWithImages:(NSArray <ZooResponseImageModel *> *) images;
@end

NS_ASSUME_NONNULL_END
