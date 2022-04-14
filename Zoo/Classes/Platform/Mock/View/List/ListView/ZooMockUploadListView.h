//
//  ZooMockUploadListView.h
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooMockBaseListView.h"
#import "ZooMockUpLoadModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ZooMockUploadListViewDelegate <NSObject>

- (void)previewClick:(ZooMockUpLoadModel *)uploadModel;

@end

@interface ZooMockUploadListView : ZooMockBaseListView

@property (nonatomic, weak) id<ZooMockUploadListViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
