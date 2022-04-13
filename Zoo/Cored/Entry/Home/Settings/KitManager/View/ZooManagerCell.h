//
//  ZooManagerCell.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooManagerCell : UICollectionViewCell

- (void)update:(NSString *)image name:(NSString *)name select:(BOOL)select editStatus:(BOOL)editStatus;

- (void)updateImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
