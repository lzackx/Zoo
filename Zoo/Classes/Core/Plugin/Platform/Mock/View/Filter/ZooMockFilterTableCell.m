//
//  ZooMockFilterTableCell.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooMockFilterTableCell.h"
#import "ZooDefine.h"

@interface ZooMockFilterTableCell()

@property (nonatomic, strong) UILabel *itemTitle;

@end

@implementation ZooMockFilterTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _itemTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ZooScreenWidth, self.zoo_height)];
        _itemTitle.textAlignment = NSTextAlignmentCenter;
        _itemTitle.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(32)];
        [self addSubview:_itemTitle];
    }
    return self;
}

- (void)renderUIWithTitle:(NSString *)title{
    _itemTitle.text = title;
    _itemTitle.textColor = [UIColor zoo_black_1];
}

- (void)selectedColor:(BOOL)selected{
    if(selected)
        _itemTitle.textColor = [UIColor zoo_blue];
    else
        _itemTitle.textColor = [UIColor zoo_black_1];
}

@end
