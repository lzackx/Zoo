//
//  ZooHealthInstructionsCell.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooHealthInstructionsCell.h"
#import "ZooDefine.h"

@interface ZooHealthInstructionsCell()

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *bgImg;
@property (nonatomic, strong) UILabel *itemLable;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, strong) NSMutableDictionary *attributes;

@end

@implementation ZooHealthInstructionsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _padding = kZooSizeFrom750_Landscape(32);
        _bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(_padding, 0, kZooSizeFrom750_Landscape(108), kZooSizeFrom750_Landscape(48))];
        [_bgImg setImage:[UIImage zoo_xcassetImageNamed:@"zoo_health_cell_bg"]];
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(_padding, _bgImg.zoo_top + _bgImg.zoo_height/8, _bgImg.zoo_width, _padding)];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor = [UIColor whiteColor];
        _title.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(28)];
        
        _itemLable = [[UILabel alloc] initWithFrame:CGRectMake(_padding, _bgImg.zoo_bottom + _padding/2, ZooScreenWidth - _padding*2, _padding)];
        _itemLable.numberOfLines = 0;
        _itemLable.textColor = [UIColor zoo_black_1];
        _itemLable.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(28)];
        
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineSpacing = kZooSizeFrom750_Landscape(8);
        paragraphStyle.alignment = NSTextAlignmentLeft;
        _attributes = [NSMutableDictionary dictionary];
        [_attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
        
        [self addSubview:_bgImg];
        [self addSubview:_title];
        [self addSubview:_itemLable];
    }
    return self;
}

- (CGFloat)renderUIWithTitle:(NSString *)title item:(NSString *)itemLable{
    
    _title.text = title;
    _itemLable.attributedText = [[NSAttributedString alloc] initWithString:itemLable attributes:_attributes];
    [_itemLable sizeToFit];
    _itemLable.frame = CGRectMake(_itemLable.zoo_left, _itemLable.zoo_top, _itemLable.zoo_width, _itemLable.zoo_height);
    return _itemLable.zoo_bottom + _padding*2;
}

@end
