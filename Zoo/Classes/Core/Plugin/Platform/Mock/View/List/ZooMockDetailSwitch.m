//
//  ZooMockCellSwitch.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooMockDetailSwitch.h"
#import "ZooDefine.h"

@interface ZooMockDetailSwitch()

@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic, assign) CGFloat size;
@end

@implementation ZooMockDetailSwitch

- (void)needArrow{
    _size = kZooSizeFrom750_Landscape(24);
    _arrow = [[UIImageView alloc] init];
    _arrow.image = [UIImage zoo_xcassetImageNamed:@"zoo_mock_detail_up"];
    _arrow.frame = CGRectMake(self.zoo_width - _size*3, self.zoo_height/2-_arrow.image.size.height/2, _arrow.image.size.width, _arrow.image.size.height);
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:_arrow];
}

- (void)setSwitchFrame{
    self.switchView.frame = CGRectMake(_arrow.zoo_left - self.switchView.zoo_width-_size*2, self.zoo_height/2-self.switchView.zoo_height/2, self.switchView.zoo_width, self.switchView.zoo_height);
}

- (void)setArrowDown:(BOOL)isDown{
    NSString *imgName = @"zoo_mock_detail_up";
    if(isDown){
        imgName = @"zoo_mock_detail_down";
    }
    _arrow.image = [UIImage zoo_xcassetImageNamed:imgName];
    _arrow.zoo_width = _arrow.image.size.width;
    _arrow.zoo_height =  _arrow.image.size.height;
}



@end
