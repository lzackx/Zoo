//
//  ZooHomeViewController.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooHomeViewController.h"
#import "UIView+Zoo.h"
#import "UIColor+Zoo.h"
#import "ZooManager.h"
#import "ZooPluginProtocol.h"
#import "ZooHomeWindow.h"
#import "ZooDefine.h"
#import "ZooHomeCell.h"
#import "ZooHomeHeadCell.h"
#import "ZooHomeFootCell.h"
#import "ZooHomeCloseCell.h"
#import "UIViewController+Zoo.h"
#import "ZooCacheManager.h"

static NSString *ZooHomeCellID = @"ZooHomeCellID";
static NSString *ZooHomeHeadCellID = @"ZooHomeHeadCellID";
static NSString *ZooHomeFootCellID = @"ZooHomeFootCellID";
static NSString *ZooHomeCloseCellID = @"ZooHomeCloseCellID";

@interface ZooHomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation ZooHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Zoo";
    [self setLeftNavBarItems:nil];
//    [self setRightNavTitle:ZooLocalizedString(@"设置")];
    
    
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor tertiarySystemBackgroundColor];
    } else {
#endif
        self.view.backgroundColor = [UIColor whiteColor];
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
    }
#endif
    NSMutableArray *dataArray = [ZooManager shareInstance].dataArray;
    _dataArray = dataArray;
    [self.view addSubview:self.collectionView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kitManagerUpdate:) name:ZooManagerUpdateNotification object:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.collectionView.frame = [self fullscreen];
}

- (void)rightNavTitleClick:(id)clickView{
}

- (void)kitManagerUpdate:(NSNotification *)aNotification {
    _dataArray = [ZooManager shareInstance].dataArray;
    [self.collectionView reloadData];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -- UICollectionView
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc] init];
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
        [_collectionView registerClass:[ZooHomeCell class] forCellWithReuseIdentifier:ZooHomeCellID];
        [_collectionView registerClass:[ZooHomeCloseCell class] forCellWithReuseIdentifier:ZooHomeCloseCellID];
        [_collectionView registerClass:[ZooHomeHeadCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ZooHomeHeadCellID];
        [_collectionView registerClass:[ZooHomeFootCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:ZooHomeFootCellID];
    }
    
    return _collectionView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < _dataArray.count) {
        return CGSizeMake(kZooSizeFrom750_Landscape(160), kZooSizeFrom750_Landscape(128));
    } else {
        return CGSizeMake(ZooScreenWidth, kZooSizeFrom750_Landscape(100));
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section < _dataArray.count) {
        return CGSizeMake(ZooScreenWidth, kZooSizeFrom750_Landscape(88));
    } else {
        return CGSizeMake(ZooScreenWidth, 0);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section < _dataArray.count) {
        return CGSizeMake(ZooScreenWidth, kZooSizeFrom750_Landscape(24));
    } else {
        return CGSizeMake(ZooScreenWidth, kZooSizeFrom750_Landscape(80));
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    view.layer.zPosition = 0.0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataArray.count + 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section < self.dataArray.count) {
        NSDictionary *dict = _dataArray[section];
        NSArray *pluginArray = dict[@"pluginArray"];
        return pluginArray.count;
    } else {
        return 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZooHomeCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:ZooHomeCellID forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if (section < _dataArray.count) {
        NSDictionary *dict = _dataArray[section];
        NSArray *pluginArray = dict[@"pluginArray"];
        NSDictionary *item = pluginArray[row];
        [cell update:item[@"icon"] name:item[@"name"]];
        [cell updateImage:item[@"image"]];
        return cell;
    } else {
        ZooHomeCloseCell *closeCell = [collectionView dequeueReusableCellWithReuseIdentifier:ZooHomeCloseCellID forIndexPath: indexPath];
        return closeCell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *view;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ZooHomeHeadCell *head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ZooHomeHeadCellID  forIndexPath:indexPath];
        [head renderUIWithTitle:nil];
        NSInteger section = indexPath.section;
        if (section < _dataArray.count) {
            NSDictionary *dict = _dataArray[section];
            [head renderUIWithTitle:dict[@"moduleName"]];
        }
        
        view = head;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        ZooHomeFootCell *foot = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:ZooHomeFootCellID forIndexPath:indexPath];
        UIColor *dyColor;
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
        if (@available(iOS 13.0, *)) {
            __weak typeof(self) weakSelf = self;
            dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
                    return [UIColor zoo_colorWithString:@"#F4F5F6"];
                } else {
                    if (indexPath.section >= weakSelf.dataArray.count) {
                        return [UIColor systemBackgroundColor];
                    } else {
                        return [UIColor zoo_colorWithString:@"#353537"];
                    }
                }
            }];
        } else {
#endif
            dyColor = [UIColor zoo_colorWithString:@"#F4F5F6"];
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
        }
#endif
        if (indexPath.section >= self.dataArray.count) {
            NSString *str = ZooLocalizedString(@"当前版本");
            NSString *last = [NSString stringWithFormat:@"%@：V%@", str, ZooVersion];
            foot.title.text = last;
            foot.title.textColor = [UIColor zoo_colorWithString:@"#999999"];
            foot.title.textAlignment = NSTextAlignmentCenter;
            foot.title.font = [UIFont systemFontOfSize:kZooSizeFrom750_Landscape(24)]; // kZooSizeFrom750
        } else {
            foot.title.text = nil;
        }
        foot.backgroundColor = dyColor;
        view = foot;
    }else{
        view = [[UICollectionReusableView alloc] init];
    }
    
    return view;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section < _dataArray.count)
        return UIEdgeInsetsMake(0, kZooSizeFrom750_Landscape(24), kZooSizeFrom750_Landscape(24), kZooSizeFrom750_Landscape(24));//分别为上、左、下、右
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    if (section < self.dataArray.count) {
        NSDictionary *dict = _dataArray[section];
        NSArray *pluginArray = dict[@"pluginArray"];
        NSDictionary *itemData = pluginArray[indexPath.row];
        NSString *pluginName = itemData[@"pluginName"];
        if(pluginName){
            Class pluginClass = NSClassFromString(pluginName);
            id<ZooPluginProtocol> plugin = [[pluginClass alloc] init];
            if ([plugin respondsToSelector:@selector(pluginDidLoad)]) {
                [plugin pluginDidLoad];
            }
            if ([plugin respondsToSelector:@selector(pluginDidLoad:)]) {
                [plugin pluginDidLoad:(NSDictionary *)itemData];
            }
            
            void (^handleBlock)(NSDictionary *itemData) = [ZooManager shareInstance].keyBlockDic[itemData[@"key"]];
            if (handleBlock) {
                handleBlock(itemData);
            }
        }
    }
}


@end
