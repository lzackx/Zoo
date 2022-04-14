//
//  ZooMockBaseModel.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooMockBaseModel.h"
#import "ZooDefine.h"

@implementation ZooMockBaseModel

-  (void)appendFormat:(NSMutableString *)info text:(NSString *)text append:(NSString *)appendInfo{
    [info appendFormat:ZooLocalizedString(text),appendInfo];
}

@end
