//
//  ZooManagerViewController.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooManagerViewController.h"
#import "ZooDefine.h"
#import "ZooManagerCell.h"
#import "ZooManager.h"
#import "UIViewController+Zoo.h"
#import "ZooManagerHeadCell.h"
#import "ZooCacheManager.h"
#import "ZooNavBarItemModel.h"

static NSString *ZooManagerCellID = @"ZooManagerCellID";
static NSString *ZooManagerHeadCellID = @"ZooManagerHeadCellID";

@interface ZooManagerViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *currentArray;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;

@property (nonatomic, assign) BOOL editStatus;

@end

@implementation ZooManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = ZooLocalizedString(@"工具管理");
    [self setRightNavTitle:ZooLocalizedString(@"编辑")];
    _editStatus = NO;
    [self setRightNavBar];
    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];

    //非编辑状态只显示show=YES的Kit
    _currentArray = [self getShowArray];
    
    [self.view addSubview:self.collectionView];
}

- (void)setRightNavBar{
    NSString *title = nil;
    if (_editStatus) {
        title = ZooLocalizedString(@"完成");
    }else{
        title = ZooLocalizedString(@"编辑");
    }
    ZooNavBarItemModel *model1 = [[ZooNavBarItemModel alloc] initWithText:title color:[UIColor zoo_blue] selector:@selector(rightNavTitleClick)];
    ZooNavBarItemModel *model2 = [[ZooNavBarItemModel alloc] initWithText:ZooLocalizedString(@"还原") color:[UIColor zoo_blue] selector:@selector(reset)];
    [self setRightNavBarItems:@[model1,model2]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.frame = [self fullscreen];
}

- (void)leftNavBackClick:(id)clickView{
    if (_editStatus) {
        [ZooAlertUtil handleAlertActionWithVC:self text:ZooLocalizedString(@"是否保存已编辑的内容") okBlock:^{
            [self rightNavTitleClick];
        } cancleBlock:^{
            
        }];
    }else{
        [super leftNavBackClick:clickView];
    }
}

- (void)reset{
    __weak typeof(self) weakSelf = self;
    [ZooAlertUtil handleAlertActionWithVC:self text:ZooLocalizedString(@"是否还原到初始状态") okBlock:^{
        __strong typeof(self) strongSelf = weakSelf;
        [[ZooCacheManager sharedInstance] saveKitManagerData:[ZooManager shareInstance].dataArray];
        strongSelf.currentArray = [self getAllArray];
        [strongSelf.collectionView reloadData];
    } cancleBlock:^{
        
    }];
}

- (void)rightNavTitleClick{
    _editStatus = !_editStatus;
    if (_editStatus) {
        //点击进入编辑状态
        [self setRightNavBar];
        [self.collectionView addGestureRecognizer:_longPress];
        _currentArray = [self getAllArray];
        [self.collectionView reloadData];
    }else{
        //点击进入完成状态
        [self setRightNavBar];
        [self.collectionView removeGestureRecognizer:_longPress];
        [[ZooCacheManager sharedInstance] saveKitManagerData:_currentArray];
        _currentArray = [self getShowArray];
        [self.collectionView reloadData];
        
        [ZooToastUtil showToastBlack:ZooLocalizedString(@"保存成功") inView:self.view];
    }
}

- (NSMutableArray *)getAllArray{
    NSMutableArray *dataArray = [[ZooCacheManager sharedInstance] kitManagerData];
    if (ARRAY_IS_NULL(dataArray)) {
        [[ZooCacheManager sharedInstance] saveKitManagerData:[ZooManager shareInstance].dataArray];
        dataArray = [[ZooCacheManager sharedInstance] kitManagerData];
    }
    return dataArray;
}

- (NSMutableArray *)getShowArray{
    NSMutableArray *dataArray = [[ZooCacheManager sharedInstance] kitShowManagerData];
    if (ARRAY_IS_NULL(dataArray)) {
        [[ZooCacheManager sharedInstance] saveKitManagerData:[ZooManager shareInstance].dataArray];
        dataArray = [[ZooCacheManager sharedInstance] kitShowManagerData];
    }
    return dataArray;
}


#pragma mark -- UICollectionView
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc] init];
        fl.minimumLineSpacing = CGFLOAT_MIN;
        fl.minimumInteritemSpacing = CGFLOAT_MIN;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:fl];
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
        if (@available(iOS 13.0, *)) {
            _collectionView.backgroundColor = [UIColor systemBackgroundColor];
        } else {
#endif
            _collectionView.backgroundColor = [UIColor whiteColor];
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
        }
#endif
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ZooManagerCell class] forCellWithReuseIdentifier:ZooManagerCellID];
        [_collectionView registerClass:[ZooManagerHeadCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ZooManagerHeadCellID];
    }
    
    return _collectionView;
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)longPress {
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
        {
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longPress locationInView:self.collectionView]];
            if (![self canMove:indexPath]) {
                break;
            }
            if (@available(iOS 9.0, *)) {
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            } else {
                // Fallback on earlier versions
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if (@available(iOS 9.0, *)) {
                [self.collectionView updateInteractiveMovementTargetPosition:[longPress locationInView:self.collectionView]];
            } else {
                // Fallback on earlier versions
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if (@available(iOS 9.0, *)) {
                [self.collectionView endInteractiveMovement];
            } else {
                // Fallback on earlier versions
            }
        }
            break;
        default:
        {
            if (@available(iOS 9.0, *)) {
                [self.collectionView cancelInteractiveMovement];
            } else {
                // Fallback on earlier versions
            }
        }
            break;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat w = kZooSizeFrom750_Landscape(750)/4;
    CGFloat h = w/187*209;
    
    CGSize size = CGSizeMake(w, h);
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGFloat w = ZooScreenWidth;
    CGFloat h = kZooSizeFrom750_Landscape(102);
    CGSize size = CGSizeMake(w, h);
    return size;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _currentArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSDictionary *dict = _currentArray[section];
    NSArray *pluginArray = dict[@"pluginArray"];
    return pluginArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZooManagerCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:ZooManagerCellID forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    NSDictionary *dict = _currentArray[section];
    NSArray *pluginArray = dict[@"pluginArray"];
    NSDictionary *item = pluginArray[row];
    [cell update:item[@"icon"] name:item[@"name"] select:[item[@"show"] boolValue] editStatus:_editStatus];
    [cell updateImage:item[@"image"]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *view;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ZooManagerHeadCell *head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ZooManagerHeadCellID  forIndexPath:indexPath];
        [head renderUIWithTitle:nil];
        NSInteger section = indexPath.section;
        if (section < _currentArray.count) {
            NSDictionary *dict = _currentArray[section];
            [head renderUIWithTitle:dict[@"moduleName"]];
        }
        
        view = head;
    }else{
        view = [[UICollectionReusableView alloc] init];
    }
    
    return view;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return _editStatus;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (!_editStatus) {
        return;
    }
    NSInteger sourceSection = sourceIndexPath.section;
    NSInteger sourceRow = sourceIndexPath.row;
    
    
    NSDictionary *sourceDict = _currentArray[sourceSection];
    NSMutableArray *sourcePluginArray = sourceDict[@"pluginArray"];
    NSDictionary *sourceItem = sourcePluginArray[sourceRow];
    
    [sourcePluginArray removeObjectAtIndex:sourceRow];
    
    NSInteger destinationSection = destinationIndexPath.section;
    NSInteger destinationRow = destinationIndexPath.row;
    NSDictionary *destinationDict = _currentArray[destinationSection];
    NSMutableArray *destinationPluginArray = destinationDict[@"pluginArray"];
    [destinationPluginArray insertObject:sourceItem atIndex:destinationRow];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!_editStatus) {
        return;
    }
    NSInteger section = indexPath.section;
    NSMutableDictionary *dict = _currentArray[section];
    NSMutableArray *pluginArray = dict[@"pluginArray"];
    NSMutableDictionary *itemData = pluginArray[indexPath.row];
    BOOL show = [itemData[@"show"] boolValue];
    if (show){
        //取消的时候要观察是不是这个section中的最后一个
        NSInteger showCount = 0;
        for (NSDictionary *subDic in pluginArray){
            BOOL show = [subDic[@"show"] boolValue];
            if (show) {
                showCount++;
            }
        }
        if (showCount == 1) {
            [ZooToastUtil showToastBlack:ZooLocalizedString(@"每一个分组至少保留一项") inView:self.view];
            return;
        }
    }
    itemData[@"show"] = @(!show);
    
    [self.collectionView reloadData];
}

#pragma mark -- private
- (BOOL)canMove:(NSIndexPath *)indexPath{
    if (!indexPath) {
        return NO;
    }
    NSInteger section = indexPath.section;
    NSMutableDictionary *dict = _currentArray[section];
    NSMutableArray *pluginArray = dict[@"pluginArray"];
    NSInteger showCount = 0;
    for (NSDictionary *subDic in pluginArray){
        BOOL show = [subDic[@"show"] boolValue];
        if (show) {
            showCount++;
        }
    }
    if (showCount <= 1) {
        [ZooToastUtil showToastBlack:ZooLocalizedString(@"每一个分组至少保留一项") inView:self.view];
        return NO;
    }
    return YES;
}


@end
