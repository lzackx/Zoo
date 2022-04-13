//
//  UIColor+ZooHierarchy.h
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ZooHierarchy)

- (NSString *)zoo_HexString;

- (NSString *)zoo_description;

- (NSString *_Nullable)zoo_systemColorName;

@end

NS_ASSUME_NONNULL_END
