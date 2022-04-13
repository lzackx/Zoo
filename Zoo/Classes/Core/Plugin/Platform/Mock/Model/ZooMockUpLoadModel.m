//
//  ZooMockUpLoadModel.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooMockUpLoadModel.h"
#import "ZooDefine.h"

@implementation ZooMockUpLoadModel

- (NSString *)info{
    NSMutableString *info = [[NSMutableString alloc] init];
    if (self.path) {
        [info appendFormat:@"path: %@\n",self.path];
    }
    if (self.query && self.query.allKeys.count>0) {
        [info appendFormat:@"query: %@\n",self.query];
    }
    if (self.body && self.body.allValues.count>0) {
        [info appendFormat :@"body: %@\n",self.body];
    }
    if (self.category) {
        [self appendFormat:info text:@"分组: %@\n" append:self.category];
    }
    if (self.owner) {
        [self appendFormat:info text:@"创建人: %@\n" append:self.owner];
    }
    if (self.editor) {
        [self appendFormat:info text:@"修改人: %@\n" append:self.editor];
    }
    if (self.result && self.result.length>0) {
        [self appendFormat:info text:@"本地是否存在mock数据: %@" append:ZooLocalizedString(@"存在")];
    }else{
        [self appendFormat:info text:@"本地是否存在mock数据: %@" append:ZooLocalizedString(@"不存在")];
    }
    
    return info;
}

@end
