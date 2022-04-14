//
//  ZooMockGPSCenterView.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooMockGPSCenterView.h"
#import "ZooDefine.h"

@interface ZooMockGPSCenterView()

@property (nonatomic, strong) UIView *circleView;
@property (nonatomic, strong) UIImageView *locationIconView;
@property (nonatomic, strong) UILabel *gpsLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation ZooMockGPSCenterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _circleView = [[UIView alloc] initWithFrame:CGRectMake(self.zoo_width/2-kZooSizeFrom750_Landscape(100)/2, self.zoo_height/2-kZooSizeFrom750_Landscape(100)/2, kZooSizeFrom750_Landscape(100), kZooSizeFrom750_Landscape(100))];
        _circleView.layer.cornerRadius = kZooSizeFrom750_Landscape(50);
        _circleView.backgroundColor = [UIColor zoo_colorWithHex:0xFFA511 andAlpha:0.37];
        [self addSubview:_circleView];
        
        _locationIconView = [[UIImageView alloc] initWithImage:[UIImage zoo_xcassetImageNamed:@"zoo_location"]];
        _locationIconView.frame = CGRectMake(self.circleView.center.x-_locationIconView.zoo_width/2, self.circleView.center.y-_locationIconView.zoo_height, _locationIconView.zoo_width, _locationIconView.zoo_height);
        [self addSubview:_locationIconView];
        
        _gpsLabel = [[UILabel alloc] init];
        _gpsLabel.textColor = [UIColor zoo_black_1];
        _gpsLabel.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(24)];
        _gpsLabel.backgroundColor = [UIColor whiteColor];
        _gpsLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_gpsLabel];
        
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage zoo_xcassetImageNamed:@"zoo_arrow_down"]];
        _arrowImageView.frame = CGRectMake(self.zoo_width/2-_arrowImageView.zoo_width/2, _locationIconView.zoo_top-kZooSizeFrom750_Landscape(20)-_arrowImageView.zoo_height, _arrowImageView.zoo_width, _arrowImageView.zoo_height);
        [self addSubview:_arrowImageView];
        
    }
    return self;
}

- (void)renderUIWithGPS:(NSString *)gps{
    _gpsLabel.text = gps;
    [_gpsLabel sizeToFit];
    CGFloat w = _gpsLabel.zoo_width + kZooSizeFrom750_Landscape(30)*2;
    CGFloat h = _gpsLabel.zoo_height + kZooSizeFrom750_Landscape(12)*2;
    _gpsLabel.frame = CGRectMake(self.zoo_width/2-w/2, _arrowImageView.zoo_top-h+kZooSizeFrom750_Landscape(10), w, h);
    _gpsLabel.layer.cornerRadius = h/2;
    _gpsLabel.clipsToBounds = YES;
}

- (void)hiddenGPSInfo:(BOOL)hidden{
    _gpsLabel.hidden = hidden;
    _arrowImageView.hidden = hidden;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    
    if (hitView == self) {
        return nil;
    }
    return hitView;
}

@end
