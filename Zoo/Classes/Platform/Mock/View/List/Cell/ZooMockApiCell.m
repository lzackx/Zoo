//
//  ZooMockApiCell.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooMockApiCell.h"
#import "ZooMockSceneButton.h"
#import "ZooMockAPIModel.h"
#import "ZooMockManager.h"

@interface ZooMockApiCell()<ZooMockSceneButtonDelegate>

@property (nonatomic, strong) UIView *sceneView;

@end

@implementation ZooMockApiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _sceneView = [[UIView alloc] init];
        [self.contentView addSubview:_sceneView];
    }
    return self;
}

- (void)renderCellWithData:(ZooMockBaseModel *)model{
    [super renderCellWithData: model];
    if(!model||!model.expand){
        _sceneView.hidden = YES;
        return ;
    }else{
        _sceneView.hidden = NO;
    }
    if (_sceneView.subviews.count>0) {
        [_sceneView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    ZooMockAPIModel *apiModel = (ZooMockAPIModel *)self.model;
    
    NSArray *sceneList = apiModel.sceneList;
    if (sceneList.count > 0) {
        _sceneView.frame = CGRectMake(0, self.infoLabel.zoo_bottom, ZooScreenWidth, [[self class] sceneViewHeight:apiModel]);
        CGFloat h = kZooSizeFrom750_Landscape(32);
        CGFloat offsetY = kZooSizeFrom750_Landscape(32);
        CGFloat offsetX = kZooSizeFrom750_Landscape(32);
        NSInteger i = 0;
        for (ZooMockScene *scene in sceneList) {
            ZooMockSceneButton *btn = [[ZooMockSceneButton alloc] init];
            btn.tag = i; i++;
            btn.delegate = self;
            [btn renderTitle:scene.name isSelected:scene.selected];
            
            CGFloat w = [ZooMockSceneButton viewWidth:scene.name];
            if (offsetX>ZooScreenWidth-kZooSizeFrom750_Landscape(32)) {
                offsetX = kZooSizeFrom750_Landscape(32);
                offsetY += kZooSizeFrom750_Landscape(32)*2;
            }
            btn.frame = CGRectMake(offsetX, offsetY, w, h);
            offsetX += w+kZooSizeFrom750_Landscape(32);
            [_sceneView addSubview:btn];
        }
    }
}

+ (CGFloat)cellHeightWith:(ZooMockBaseModel *)model{
    CGFloat cellHeight = [super cellHeightWith:model];
    
    if (model && model.expand){
        ZooMockAPIModel *apiModel = (ZooMockAPIModel *)model;
        cellHeight += [self sceneViewHeight:apiModel];
    }

    return cellHeight;
}


+ (CGFloat)sceneViewHeight:(ZooMockAPIModel *)model{
    NSArray *sceneList = model.sceneList;
    
    CGFloat w = kZooSizeFrom750_Landscape(32);
    CGFloat h = 0;
    if (sceneList.count>0) {
        h = kZooSizeFrom750_Landscape(32);
        h += kZooSizeFrom750_Landscape(32);
    }
    for (ZooMockScene *scene in sceneList) {
        w += [ZooMockSceneButton viewWidth:scene.name];
        if (w > ZooScreenWidth-kZooSizeFrom750_Landscape(32)*2) {
            w = kZooSizeFrom750_Landscape(32);
            h += kZooSizeFrom750_Landscape(32)*2;
        }
        w += kZooSizeFrom750_Landscape(32);
    }
    
    return h;
}

#pragma mark - ZooMockSceneButtonDelegate
- (void)sceneBtnClick:(NSInteger)tag{
    ZooMockAPIModel *apiModel = (ZooMockAPIModel *)self.model;
    NSArray<ZooMockScene *> *sceneList = apiModel.sceneList;
    for (int i=0; i<sceneList.count; i++) {
        ZooMockScene *scene = sceneList[i];
        if (i == tag) {
            scene.selected = YES;
        }else {
            scene.selected = NO;
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(sceneBtnClick)]) {
        [self.delegate sceneBtnClick];
    }
}

#pragma mark -- ZooSwitchViewDelegate
- (void)changeSwitchOn:(BOOL)on sender:(id)sender{
    self.model.selected = on;
    
    // 1、是否开启mock功能 : mock列表中只要有一个选中就需要打开mock功能
    BOOL needMockOn = NO;
    for (ZooMockAPIModel *api in [ZooMockManager sharedInstance].mockArray) {
        if (api.selected) {
            needMockOn = YES;
        }
    }
    
    [ZooMockManager sharedInstance].mock = needMockOn;
    
    ZooMockAPIModel *apiModel = (ZooMockAPIModel *)self.model;
    
    if (on) {
        // 2、如果场景没有选中 默认选中第一个
        NSArray<ZooMockScene *> *sceneList = apiModel.sceneList;
        BOOL select = NO;
        for (ZooMockScene *s in sceneList) {
            if (s.selected) {
                select = s.selected;
            }
        }
        if (!select && sceneList.count>0) {
            ZooMockScene *s = sceneList[0];
            s.selected = YES;
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellSwitchClick)]) {
        [self.delegate cellSwitchClick];
    }
}

@end
