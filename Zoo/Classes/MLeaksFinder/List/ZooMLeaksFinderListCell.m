//
//  ZooMLeaksFinderListCell.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooMLeaksFinderListCell.h"
#import "ZooDefine.h"

@interface ZooMLeaksFinderListCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation ZooMLeaksFinderListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor zoo_black_1];
        _titleLabel.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(28)];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)renderCellWithData:(NSDictionary *)dic{
    self.titleLabel.text = dic[@"className"];
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(kZooSizeFrom750_Landscape(32), [[self class] cellHeight]/2-self.titleLabel.zoo_height/2, ZooScreenWidth - 120, self.titleLabel.zoo_height);
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.minimumScaleFactor = 0.1;
    
}

+ (CGFloat)cellHeight{
    return kZooSizeFrom750_Landscape(104);
}


@end
