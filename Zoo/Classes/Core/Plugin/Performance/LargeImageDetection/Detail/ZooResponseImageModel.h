//
//  ZooResponseImageModel.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZooResponseImageModel : NSObject
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, copy) NSString *size;

- (instancetype)initWithResponse: (NSURLResponse *)response data:(NSData *) data;
@end

NS_ASSUME_NONNULL_END
