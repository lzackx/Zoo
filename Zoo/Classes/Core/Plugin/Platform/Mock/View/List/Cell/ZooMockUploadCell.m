//
//  ZooMockUploadCell.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooMockUploadCell.h"
#import "ZooMockManager.h"
#import "ZooNetworkUtil.h"
#import "ZooManager.h"
#import "ZooToastUtil.h"

@interface ZooMockUploadCell()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIButton *previewBtn;
@property (nonatomic, strong) UIButton *uploadBtn;

@end

@implementation ZooMockUploadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _containerView = [[UIView alloc] init];
        [self.contentView addSubview:_containerView];
        
        _previewBtn = [[UIButton alloc] init];
        [_previewBtn setTitle:ZooLocalizedString(@"数据预览") forState:UIControlStateNormal];
        [_previewBtn setTitleColor:[UIColor zoo_blue] forState:UIControlStateNormal];
        [_previewBtn addTarget:self action:@selector(preview) forControlEvents:UIControlEventTouchUpInside];
        [_containerView addSubview:_previewBtn];
        
        _uploadBtn = [[UIButton alloc] init];
        [_uploadBtn setTitle:ZooLocalizedString(@"上传") forState:UIControlStateNormal];
        [_uploadBtn setTitleColor:[UIColor zoo_blue] forState:UIControlStateNormal];
        [_uploadBtn addTarget:self action:@selector(upload) forControlEvents:UIControlEventTouchUpInside];
        [_containerView addSubview:_uploadBtn];
    }
    return self;
}

- (void)renderCellWithData:(ZooMockBaseModel *)model{
    [super renderCellWithData: model];
    if(!model||!model.expand){
        _containerView.hidden = YES;
        return ;
    }else{
        _containerView.hidden = NO;
    }
    
    [_previewBtn sizeToFit];
    _previewBtn.frame = CGRectMake(0, 0, _previewBtn.zoo_width, _previewBtn.zoo_height);
    [_uploadBtn sizeToFit];
    _uploadBtn.frame = CGRectMake(_previewBtn.zoo_right+kZooSizeFrom750_Landscape(48), 0, _uploadBtn.zoo_width, _uploadBtn.zoo_height);
    
    _containerView.frame = CGRectMake(kZooSizeFrom750_Landscape(32), self.infoLabel.zoo_bottom, ZooScreenWidth-kZooSizeFrom750_Landscape(32)*2, _previewBtn.zoo_height);
}

+ (CGFloat)cellHeightWith:(ZooMockBaseModel *)model{
    CGFloat cellHeight = [super cellHeightWith:model];
    
    if (model && model.expand){
        cellHeight += kZooSizeFrom750_Landscape(32);
        cellHeight += kZooSizeFrom750_Landscape(32);
    }

    return cellHeight;
}

- (void)preview{
    ZooMockUpLoadModel *upload = (ZooMockUpLoadModel *)self.model;
    if (self.delegate && [self.delegate respondsToSelector:@selector(previewClick:)]) {
        [self.delegate previewClick:upload];
    }
}

- (void)upload{
    ZooMockUpLoadModel *upload = (ZooMockUpLoadModel *)self.model;
    [[ZooMockManager sharedInstance] uploadSaveData:upload atView:self];
}

- (NSString *)convertToJsonData:(NSDictionary *)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;

    if (!jsonData) {
        ZooLog(@"%@",error);
    } else {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }

    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];

    NSRange range = {0,jsonString.length};

    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];

    NSRange range2 = {0,mutStr.length};

    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];

    return mutStr;
}

#pragma mark -- ZooSwitchViewDelegate
- (void)changeSwitchOn:(BOOL)on sender:(id)sender{
    self.model.selected = on;
    
    // 1、是否开启网络拦截功能 : mock列表中只要有一个选中就需要打开mock功能
    BOOL needMockOn = NO;
    for (ZooMockAPIModel *api in [ZooMockManager sharedInstance].upLoadArray) {
        if (api.selected) {
            needMockOn = YES;
        }
    }
    [ZooMockManager sharedInstance].mock = needMockOn;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellSwitchClick)]) {
        [self.delegate cellSwitchClick];
    }
}

@end
