//
//  ZooHealthCountdownWindow.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooHealthCountdownWindow.h"
#import "ZooStatusBarViewController.h"
#import "ZooDefine.h"

@interface ZooHealthCountdownWindow()

@property (nonatomic, assign) CGFloat showViewSize;
@property (nonatomic, assign) int height;
@property (nonatomic, assign) int width;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger count;

@end

@implementation ZooHealthCountdownWindow

+ (ZooHealthCountdownWindow *)shareInstance{
    static dispatch_once_t once;
    static ZooHealthCountdownWindow *instance;
    dispatch_once(&once, ^{
        instance = [[ZooHealthCountdownWindow alloc] init];
    });
    return instance;
}

- (instancetype)init{
    _showViewSize = kZooSizeFrom750_Landscape(100);
    CGFloat x = ZooScreenWidth - _showViewSize;
    CGFloat y = ZooScreenHeight/5;
    
    self = [super initWithFrame:CGRectMake(x, y, _showViewSize, _showViewSize)];
    if (self) {
    #if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
        if (@available(iOS 13.0, *)) {
            for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes){
                if (windowScene.activationState == UISceneActivationStateForegroundActive){
                    self.windowScene = windowScene;
                    break;
                }
            }
        }
    #endif
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _showViewSize, _showViewSize)];
        _numberLabel.textColor = [UIColor zoo_colorWithString:@"#3CBCA3"];
        _numberLabel.font = [UIFont systemFontOfSize:_showViewSize*2/5];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_numberLabel];
        self.backgroundColor = [UIColor clearColor];
        self.windowLevel = UIWindowLevelStatusBar + 50;
        self.layer.cornerRadius = _showViewSize/2;
        self.layer.masksToBounds = YES;//保证显示
        self.layer.borderWidth = _showViewSize/20;
        self.layer.borderColor = _numberLabel.textColor.CGColor;
        NSString *version= [UIDevice currentDevice].systemVersion;
        if(version.doubleValue >=10.0) {
            if (!self.rootViewController) {
                self.rootViewController = [[UIViewController alloc] init];
            }
        }else{
            //iOS9.0的系统中，新建的window设置的rootViewController默认没有显示状态栏
            if (!self.rootViewController) {
                self.rootViewController = [[ZooStatusBarViewController alloc] init];
            }
        }
        UIPanGestureRecognizer *move = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_move:)];
        [self addGestureRecognizer:move];
    }
    return self;
}

- (void)_move:(UIPanGestureRecognizer *)sender{
    //1、获得拖动位移
    CGPoint offsetPoint = [sender translationInView:sender.view];
    //2、清空拖动位移
    [sender setTranslation:CGPointZero inView:sender.view];
    //3、重新设置控件位置
    UIView *panView = sender.view;
    CGFloat newX = panView.zoo_centerX+offsetPoint.x;
    CGFloat newY = panView.zoo_centerY+offsetPoint.y;
    if (newX < _showViewSize/2) {
        newX = _showViewSize/2;
    }
    if (newX > ZooScreenWidth - _showViewSize/2) {
        newX = ZooScreenWidth - _showViewSize/2;
    }
    if (newY < _showViewSize/2) {
        newY = _showViewSize/2;
    }
    if (newY > ZooScreenHeight - _showViewSize/2) {
        newY = ZooScreenHeight - _showViewSize/2;
    }
    panView.center = CGPointMake(newX, newY);
}


- (void)secondBtnAction{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
        [_timer fire];
    }
}
//定时操作，更新UI
- (void)handleTimer {
    if (self.count < 0) {
        [self hide];
    } else {
        self.numberLabel.text = [NSString stringWithFormat:@"%zi",self.count];
    }
    self.count--;
}

- (void)start:(NSInteger)number{
    self.hidden = NO;
    _count = number > 0 ? number: 10;
    [self secondBtnAction];
}

- (void)hide{
    self.hidden = YES;
    [_timer invalidate];
    _timer = nil;
}

- (NSInteger)getCountdown{
    return _count;
}

@end
