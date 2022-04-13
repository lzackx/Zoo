//
//  ZooHomeCell.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooHomeCell : UICollectionViewCell

- (void)update:(NSString *)image name:(NSString *)name;
- (void)updateImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
