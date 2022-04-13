//
//  ZooHealthHomeView.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <UIKit/UIKit.h>
#import "ZooHealthBtnView.h"
#import "ZooHealthStartingTitle.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ZooHealthHomeBlock)(void);

@interface ZooHealthHomeView : UIView

@property (nonatomic, strong) ZooHealthBtnView *btnView;
@property (nonatomic, strong) ZooHealthStartingTitle *startingTitle;

- (void)addBlock:(ZooHealthHomeBlock)block;

@end

NS_ASSUME_NONNULL_END
