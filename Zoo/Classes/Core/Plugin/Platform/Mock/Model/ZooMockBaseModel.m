//
//  ZooMockBaseModel.m
//  ZooKit
//
//  Created by lZackx on 04/12/2022 
//

#import "ZooMockBaseModel.h"
#import "ZooDefine.h"

@implementation ZooMockBaseModel

-  (void)appendFormat:(NSMutableString *)info text:(NSString *)text append:(NSString *)appendInfo{
    [info appendFormat:ZooLocalizedString(text),appendInfo];
}

@end
