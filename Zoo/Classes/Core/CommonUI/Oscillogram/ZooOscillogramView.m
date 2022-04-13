//
//  ZooOscillogramView.m
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import "ZooOscillogramView.h"
#import "ZooDefine.h"

@implementation ZooPoint

@end

@interface ZooOscillogramView()<UIScrollViewDelegate>

@property (nonatomic, assign) CGFloat kStartX;

@property (nonatomic, strong) NSMutableArray *pointList;
@property (nonatomic, strong) NSMutableArray *pointLayerList;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UILabel *lowValueLabel;
@property (nonatomic, strong) UILabel *highValueLabel;

@property (nonatomic, strong) CAShapeLayer *lineLayer;
@property (nonatomic, strong) UILabel       *tipLabel;

@end

@implementation ZooOscillogramView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _kStartX = kZooSizeFrom750_Landscape(52);
        
        self.backgroundColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        self.clipsToBounds = NO;
        
        _strokeColor = [UIColor orangeColor];
        _numberOfPoints = 12;
        _pointList = [NSMutableArray array];
        _pointLayerList = [NSMutableArray array];
        
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(_kStartX, self.zoo_height-kZooSizeFrom750_Landscape(1), self.zoo_width, kZooSizeFrom750_Landscape(1))];
        _bottomLine.backgroundColor = [UIColor zoo_colorWithString:@"#999999"];
        [self addSubview:_bottomLine];
        
        _lowValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.zoo_height-kZooSizeFrom750_Landscape(28)/2, _kStartX, kZooSizeFrom750_Landscape(28))];
        _lowValueLabel.text = @"0";
        _lowValueLabel.textColor = [UIColor whiteColor];
        _lowValueLabel.textAlignment = NSTextAlignmentCenter;
        _lowValueLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:_lowValueLabel];
        
        _highValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -kZooSizeFrom750_Landscape(28)/2, _kStartX, kZooSizeFrom750_Landscape(28))];
        _highValueLabel.text = @"100";
        _highValueLabel.textColor = [UIColor whiteColor];
        _highValueLabel.textAlignment = NSTextAlignmentCenter;
        _highValueLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:_highValueLabel];
        
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textColor = [UIColor zoo_colorWithString:@"#00DFDD"];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(20)];
        _tipLabel.lineBreakMode = NSLineBreakByClipping;
        [self addSubview:_tipLabel];
    }
    
    return self;
}

- (void)setLowValue:(NSString *)value{
    _lowValueLabel.text = value;
}

- (void)setHightValue:(NSString *)value{
    _highValueLabel.text = value;
}

- (void)addHeightValue:(CGFloat)showHeight andTipValue:(NSString *)tipValue{
    CGFloat width = self.zoo_width;
    CGFloat height = self.zoo_height;
    CGFloat step = width / _numberOfPoints;
    if (_pointList.count == 0) {
        _x = _kStartX;
    }else{
        if (_x <= width-step) {
            _x += step;
        }
    }
    
    _y = fabs(MIN(height, showHeight));
    ZooPoint *point = [[ZooPoint alloc] init];
    point.x = _x;
    point.y = _y;
    [_pointList addObject:point];
    
    if (_pointList.count > _numberOfPoints) {
        NSMutableArray *oldList = [NSMutableArray array];
        
        for (ZooPoint *point in _pointList) {
            point.x -= step;
            if (point.x < _kStartX) {
                [oldList addObject:point];
            }
        }
        
        [_pointList removeObjectsInArray:oldList];
    }
    
    [self drawLine];
    [self drawTipViewWithValue:tipValue point:point time:nil];
}

- (void)drawLine{
    if (_lineLayer) {
        [_lineLayer removeFromSuperlayer];
    }
    if (_pointLayerList.count>0) {
        for (CALayer *layer in _pointLayerList) {
            [layer removeFromSuperlayer];
        }
        _pointLayerList = [NSMutableArray array];
    }
    if (self.pointList.count==0) {
        return ;
    }
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    ZooPoint *point = self.pointList[0];
    CGPoint p1 = CGPointMake(point.x, self.zoo_height - point.y);
    [path moveToPoint:p1];
    [self addPointLayer:p1];
    
    for (int i=1; i<self.pointList.count; i++) {
        point = self.pointList[i];
        CGPoint p2 = CGPointMake(point.x, self.zoo_height - point.y);
        [path addLineToPoint:p2];
        
        [self addPointLayer:p2];
    }
    
    path.lineWidth = 2.;
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.strokeColor = [UIColor zoo_colorWithString:@"#00DFDD"].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    
    _lineLayer = layer;
    
    [self.layer addSublayer:layer];
    
    for (CALayer *layer in _pointLayerList) {
        [self.layer addSublayer:layer];
    }
}

- (void)addPointLayer:(CGPoint)point{
    CALayer *pointLayer = [CALayer layer];
    pointLayer.backgroundColor = [UIColor zoo_colorWithString:@"#00DFDD"].CGColor;
    pointLayer.cornerRadius = 2;
    pointLayer.frame = CGRectMake(point.x-kZooSizeFrom750_Landscape(8)/2, point.y-kZooSizeFrom750_Landscape(8)/2, kZooSizeFrom750_Landscape(8), kZooSizeFrom750_Landscape(8));
    [_pointLayerList addObject:pointLayer];
}

- (void)drawTipViewWithValue:(NSString *)tip point:(ZooPoint *)point time:(NSString *)time {
    if (_tipLabel.hidden) {
        _tipLabel.hidden = NO;
    }
    
    if (time) {
        _tipLabel.text = [NSString stringWithFormat:@"%@\n%@", tip, time];
        _tipLabel.numberOfLines = 2;
    } else {
        _tipLabel.text = tip;
        _tipLabel.numberOfLines = 1;
    }
    
    [_tipLabel sizeToFit];
    _tipLabel.frame = CGRectMake(point.x, self.zoo_height-point.y-_tipLabel.zoo_height, _tipLabel.zoo_width, _tipLabel.zoo_height);
    //self.indicatorLayer.frame = CGRectMake(point.x, 0, 1, self.bottomLine.zoo_bottom);
}

- (void)clear {
    if (_pointLayerList.count>0) {
        for (CALayer *layer in _pointLayerList) {
            [layer removeFromSuperlayer];
        }
        _pointLayerList = [NSMutableArray array];
    }
    if (_lineLayer) {
        [_lineLayer removeFromSuperlayer];
    }
    _pointList = [NSMutableArray array];
    _tipLabel.hidden = YES;
}




@end
