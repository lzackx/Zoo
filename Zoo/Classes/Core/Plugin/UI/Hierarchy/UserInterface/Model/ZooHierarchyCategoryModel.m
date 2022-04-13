//
//  ZooHierarchyCategoryModel.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooHierarchyCategoryModel.h"

@implementation ZooHierarchyCategoryModel

- (instancetype)initWithTitle:(NSString *)title items:(NSArray <ZooHierarchyCellModel *>*)items {
    if (self = [super init]) {
        _title = title;
        _items = [items copy];
    }
    return self;
}

@end
