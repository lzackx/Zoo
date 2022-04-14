//
//  ZooCocoaLumberjackLevelView.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooCocoaLumberjackLevelView.h"
#import "ZooDefine.h"

@interface ZooCocoaLumberjackLevelView()

@property (nonatomic, strong) UISegmentedControl *segment;

@end

@implementation ZooCocoaLumberjackLevelView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *dataArray = @[@"Verbose",@"Debug",@"Info",@"Warn",@"Error"];
        _segment = [[UISegmentedControl alloc] initWithItems:dataArray];
        _segment.frame = CGRectMake(kZooSizeFrom750_Landscape(32), self.zoo_height/2-kZooSizeFrom750_Landscape(68)/2, self.zoo_width-kZooSizeFrom750_Landscape(32)*2, kZooSizeFrom750_Landscape(68));
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
        if (@available(iOS 13, *)) {
           _segment.selectedSegmentTintColor = [UIColor zoo_colorWithString:@"#337CC4"];
        } else {
#endif
            _segment.tintColor = [UIColor zoo_colorWithString:@"#337CC4"];
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
        }
#endif
        [_segment setSelectedSegmentIndex:0];
        [_segment addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_segment];
    }
    return self;
}

-(void)segmentChange:(UISegmentedControl *)sender{
    NSInteger index = sender.selectedSegmentIndex;
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentSelected:)]) {
        [self.delegate segmentSelected:index];
    }
}



@end
