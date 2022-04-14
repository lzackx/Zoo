//
//  ZooHealthAlertView.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooHealthAlertView.h"
#import "ZooToastUtil.h"
#import "ZooDefine.h"
#import "ZooHealthEndInputView.h"

@interface ZooHealthAlertView()<UITextFieldDelegate>

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) NSMutableArray *inputViewArray;
@property (nonatomic, strong) UIButton *okBtn;
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) UIButton *quitBtn;
@property (nonatomic, copy) ZooHealthAlertOKActionBlock okBlock;
@property (nonatomic, copy) ZooHealthAlertCancleActionBlock cancleBlock;
@property (nonatomic, copy) ZooHealthAlertQuitActionBlock quitBlock;

@end

@implementation ZooHealthAlertView

- (instancetype)init{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.6];
        self.userInteractionEnabled = YES;
        _padding = kZooSizeFrom750_Landscape(134);
        _width = self.zoo_width - _padding*2;
        _height = _padding;
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(_padding, self.zoo_height/5, _width, _height)];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = kZooSizeFrom750_Landscape(10);
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, _padding/3, _width, _padding/2)];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(30)];
        _title.textColor = [UIColor zoo_black_1];
        
        _inputViewArray = [[NSMutableArray alloc] init];

        _okBtn = [[UIButton alloc] initWithFrame:CGRectMake(_width/3*2, 0, _width/3, kZooSizeFrom750_Landscape(90))];
        _okBtn.titleLabel.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(30)];
        [_okBtn.layer setBorderColor:[UIColor zoo_black_3].CGColor];
        [_okBtn.layer setBorderWidth:kZooSizeFrom750_Landscape(0.5)];
        [_okBtn.layer setMasksToBounds:YES];
        [_okBtn setTitleColor:[UIColor zoo_black_3] forState:UIControlStateNormal];
        [_okBtn setTitle:ZooLocalizedString(@"确定") forState:UIControlStateNormal];
        _okBtn.enabled = NO;
        [_okBtn addTarget:self action:@selector(okBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _quitBtn = [[UIButton alloc] initWithFrame:CGRectMake(_width/3, 0, _width/3, kZooSizeFrom750_Landscape(90))];
        _quitBtn.titleLabel.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(30)];
        [_quitBtn.layer setBorderColor:[UIColor zoo_black_3].CGColor];
        [_quitBtn.layer setBorderWidth:kZooSizeFrom750_Landscape(0.5)];
        [_quitBtn.layer setMasksToBounds:YES];
        [_quitBtn setTitleColor:[UIColor zoo_black_3] forState:UIControlStateNormal];
        [_quitBtn setTitle:ZooLocalizedString(@"丢弃") forState:UIControlStateNormal];
        [_quitBtn addTarget:self action:@selector(quitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _width/3, _okBtn.zoo_height)];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(30)];
        [_cancleBtn.layer setBorderColor:[UIColor zoo_black_3].CGColor];
        [_cancleBtn.layer setBorderWidth:kZooSizeFrom750_Landscape(0.5)];
        [_cancleBtn.layer setMasksToBounds:YES];
        [_cancleBtn setTitleColor:[UIColor zoo_black_3] forState:UIControlStateNormal];
        [_cancleBtn setTitle:ZooLocalizedString(@"取消") forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(cancleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_alertView];
        
        [_alertView addSubview:_title];
        [_alertView addSubview:_okBtn];
        [_alertView addSubview:_quitBtn];
        [_alertView addSubview:_cancleBtn];
        
    }
    return self;
}

- (void)renderUI:(NSString *)title placeholder:(NSArray*)placeholders inputTip:(NSArray*)inputTips ok:(NSString *)okText quit:(NSString *)quitText cancle:(NSString *)cancleText  okBlock:(ZooHealthAlertOKActionBlock)okBlock quitBlock:(ZooHealthAlertQuitActionBlock) quitBlock
cancleBlock:(ZooHealthAlertCancleActionBlock)cancleBlock{
    int index = 0;
    _title.text = title;
    NSString *placeholder = nil;
    for (NSString* inputTip in inputTips) {
        ZooHealthEndInputView *inputView = [[ZooHealthEndInputView alloc] initWithFrame:CGRectMake(0, _height, _width, _padding)];
        if(index < placeholders.count){
            placeholder = placeholders[index];
        }else{
            placeholder = @"";
        }
        [inputView renderUIWithTitle:inputTip placeholder:placeholder];
        inputView.textField.delegate = self;
        [_alertView addSubview:inputView];
        [_inputViewArray addObject:inputView];
        _height += _padding + kZooSizeFrom750_Landscape(10);
        index++;
    }
    _height += kZooSizeFrom750_Landscape(38);
    _okBtn.frame = CGRectMake(_okBtn.zoo_x, _height, _okBtn.zoo_width, _okBtn.zoo_height);
    if(okText.length>0){
        [_okBtn setTitle:okText forState:UIControlStateNormal];
    }
    _quitBtn.frame = CGRectMake(_quitBtn.zoo_x, _height, _quitBtn.zoo_width, _quitBtn.zoo_height);
    if (quitText.length>0) {
        [_quitBtn setTitle:quitText forState:UIControlStateNormal];
    }
    _cancleBtn.frame = CGRectMake(_cancleBtn.zoo_x, _height, _cancleBtn.zoo_width, _cancleBtn.zoo_height);
    if(cancleText.length>0){
        [_cancleBtn setTitle:cancleText forState:UIControlStateNormal];
    }
    _height += _okBtn.zoo_height;
    _alertView.frame = CGRectMake(_padding, _alertView.zoo_y, _width, _height);
    self.okBlock = okBlock;
    self.cancleBlock = cancleBlock;
    self.quitBlock = quitBlock;
}

- (NSArray *)getInputText{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (ZooHealthEndInputView *inputView in _inputViewArray) {
        [array addObject:inputView.textField.text];
    }
    return array;
}

- (void)cancleBtnAction:(id)sender{
    self.cancleBlock ? self.cancleBlock() : nil;
    self.hidden = YES;
}

- (void)okBtnAction:(id)sender{
    self.okBlock ? self.okBlock() : nil;
    self.hidden = YES;
}

- (void)quitBtnAction:(id)sender{
    self.quitBlock ? self.quitBlock() : nil;
    self.hidden = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    BOOL enabled = YES;
    for (ZooHealthEndInputView *inputView in _inputViewArray) {
        if(inputView.textField.text.length <= 0){
            enabled = NO;
            break;
        }
    }
    _okBtn.enabled = enabled;
    if(enabled){
        [_okBtn setTitleColor:[UIColor zoo_black_1] forState:UIControlStateNormal];
    }else{
        [_okBtn setTitleColor:[UIColor zoo_black_3] forState:UIControlStateNormal];
    }
}
@end
