//
//  NSURLRequest+Zoo.h
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (Zoo)

- (NSString *)requestId;
- (void)setRequestId:(NSString *)requestId;


- (NSNumber*)startTime;
- (void)setStartTime:(NSNumber*)startTime;

@end
