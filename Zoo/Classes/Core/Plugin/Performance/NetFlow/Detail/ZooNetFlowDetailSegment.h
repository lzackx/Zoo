//
//  ZooNetFlowDetailSegment.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZooNetFlowDetailSegmentDelegate <NSObject>

- (void)segmentClick:(NSInteger)index;

@end

@interface ZooNetFlowDetailSegment : UIView

@property (nonatomic, weak) id<ZooNetFlowDetailSegmentDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
