//
//  ZooViewAlignManager.m
//  Zoo
//
//  Created by lZackx on 04/12/2022 
//

#import "ZooViewAlignManager.h"
#import "ZooDefine.h"
#import "ZooViewAlignView.h"


@interface ZooViewAlignManager()

@property (nonatomic, strong) ZooViewAlignView *alignView;

@end

@implementation ZooViewAlignManager

+ (ZooViewAlignManager *)shareInstance{
    static dispatch_once_t once;
    static ZooViewAlignManager *instance;
    dispatch_once(&once, ^{
        instance = [[ZooViewAlignManager alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closePlugin:) name:ZooClosePluginNotification object:nil];
        [[ZooUtil getKeyWindow] addObserver:self forKeyPath:@"rootViewController" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)dealloc {
     [[ZooUtil getKeyWindow] removeObserver:self forKeyPath:@"rootViewController"];
}

- (void)show{
    if (!_alignView) {
        _alignView = [[ZooViewAlignView alloc] init];
//        _alignView.hidden = YES;
        [_alignView hide];
        [[ZooUtil getKeyWindow] addSubview:_alignView];
    }
//    _alignView.hidden = NO;
    [_alignView show];
}

- (void)hidden{
//    _alignView.hidden = YES;
    [_alignView hide];
}

- (void)closePlugin:(NSNotification *)notification{
    [self hidden];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    [[ZooUtil getKeyWindow] bringSubviewToFront:self.alignView];
}

@end
