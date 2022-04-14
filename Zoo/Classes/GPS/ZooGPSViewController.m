//
//  ZooGPSViewController.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooGPSViewController.h"
#import <MapKit/MapKit.h>
#import "UIImage+Zoo.h"
#import "UIView+Zoo.h"
#import "ZooDefine.h"
#import "ZooCacheManager.h"
#import "ZooToastUtil.h"
#import "ZooGPSMocker.h"
#import "Zooi18NUtil.h"
#import "ZooMockGPSOperateView.h"
#import "ZooMockGPSInputView.h"
#import "ZooMockGPSCenterView.h"

@interface ZooGPSViewController ()<MKMapViewDelegate,ZooMockGPSInputViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) ZooMockGPSOperateView *operateView;
@property (nonatomic, strong) ZooMockGPSInputView *inputView;
@property (nonatomic, strong) ZooMockGPSCenterView *mapCenterView;

@end

@implementation ZooGPSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = ZooLocalizedString(@"Mock GPS");
    
    [self initUI];
}

- (BOOL)needBigTitleView{
    return YES;
}

- (void)initUI{
    _operateView = [[ZooMockGPSOperateView alloc] initWithFrame:CGRectMake(kZooSizeFrom750_Landscape(6), self.bigTitleView.zoo_bottom+kZooSizeFrom750_Landscape(24), self.view.zoo_width-2*kZooSizeFrom750_Landscape(6), kZooSizeFrom750_Landscape(124))];
    _operateView.switchView.on = [[ZooCacheManager sharedInstance] mockGPSSwitch];
    [self.view addSubview:_operateView];
    [_operateView.switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    _inputView = [[ZooMockGPSInputView alloc] initWithFrame:CGRectMake(kZooSizeFrom750_Landscape(6), _operateView.zoo_bottom+kZooSizeFrom750_Landscape(17), self.view.zoo_width-2*kZooSizeFrom750_Landscape(6), kZooSizeFrom750_Landscape(170))];
    _inputView.delegate = self;
    [self.view addSubview:_inputView];
    
    //获取定位服务授权
    [self requestUserLocationAuthor];
    //初始化地图
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, self.bigTitleView.zoo_bottom, self.view.zoo_width, self.view.zoo_height-self.bigTitleView.zoo_bottom)];
    mapView.mapType = MKMapTypeStandard;
    mapView.delegate = self;
    [self.view addSubview:mapView];
    self.mapView = mapView;
    
    [self.view sendSubviewToBack:self.mapView];
    
    _mapCenterView = [[ZooMockGPSCenterView alloc] initWithFrame:CGRectMake(_mapView.zoo_width/2-kZooSizeFrom750_Landscape(250)/2, _mapView.zoo_height/2-kZooSizeFrom750_Landscape(250)/2, kZooSizeFrom750_Landscape(250), kZooSizeFrom750_Landscape(250))];
    [_mapView addSubview:_mapCenterView];

    if (_operateView.switchView.on) {
        CLLocationCoordinate2D coordinate = [[ZooCacheManager sharedInstance] mockCoordinate];
        [_mapCenterView hiddenGPSInfo:NO];
        [_mapCenterView renderUIWithGPS:[NSString stringWithFormat:@"%f , %f",coordinate.longitude,coordinate.latitude]];
        [self.mapView setCenterCoordinate:coordinate animated:NO];
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        [[ZooGPSMocker shareInstance] mockPoint:loc];
    }else{
        [_mapCenterView hiddenGPSInfo:YES];
        [[ZooGPSMocker shareInstance] stopMockPoint];
    }
}
    

- (void)switchAction:(id)sender{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    [[ZooCacheManager sharedInstance] saveMockGPSSwitch:isButtonOn];
    if (isButtonOn) {
        CLLocationCoordinate2D coordinate = [[ZooCacheManager sharedInstance] mockCoordinate];
        [_mapCenterView hiddenGPSInfo:NO];
        [_mapCenterView renderUIWithGPS:[NSString stringWithFormat:@"%f , %f",coordinate.longitude,coordinate.latitude]];
        [self.mapView setCenterCoordinate:coordinate animated:NO];
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        [[ZooGPSMocker shareInstance] mockPoint:loc];
    }else{
        [_mapCenterView hiddenGPSInfo:YES];
        [[ZooGPSMocker shareInstance] stopMockPoint];
    }
}

#pragma mark - ZooMockGPSInputViewDelegate
- (void)inputViewOkClick:(NSString *)gps{
    if (![[ZooCacheManager sharedInstance] mockGPSSwitch]) {
        [ZooToastUtil showToast:ZooLocalizedString(@"mock开关没有打开") inView:self.view];
        return;
    }
    NSArray *array = [gps componentsSeparatedByString:@" "];
    if(array && array.count == 2){
        NSString *longitudeValue = array[0];
        NSString *latitudeValue = array[1];
        if (longitudeValue.length==0 || latitudeValue.length==0) {
            [ZooToastUtil showToast:ZooLocalizedString(@"经纬度不能为空") inView:self.view];
            return;
        }
        
        CGFloat longitude = [longitudeValue floatValue];
        CGFloat latitude = [latitudeValue floatValue];
        if (longitude < -180 || longitude > 180) {
            [ZooToastUtil showToast:ZooLocalizedString(@"经度不合法") inView:self.view];
            return;
        }
        if (latitude < -90 || latitude > 90){
            [ZooToastUtil showToast:ZooLocalizedString(@"纬度不合法") inView:self.view];
            return;
        }
        
        CLLocationCoordinate2D coordinate;
        coordinate.longitude = longitude;
        coordinate.latitude = latitude;

        [_mapCenterView hiddenGPSInfo:NO];
        [_mapCenterView renderUIWithGPS: [NSString stringWithFormat:@"%f , %f",coordinate.longitude,coordinate.latitude]];
        [self.mapView setCenterCoordinate:coordinate animated:NO];
        
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        [[ZooGPSMocker shareInstance] mockPoint:loc];
    }else{
        [ZooToastUtil showToast:ZooLocalizedString(@"格式不正确") inView:self.view];
        return;
    }
    
}

//如果没有获得定位授权，获取定位授权请求
- (void)requestUserLocationAuthor{
    self.locationManager = [[CLLocationManager alloc] init];
    if ([CLLocationManager locationServicesEnabled]) {
        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
            [self.locationManager requestWhenInUseAuthorization];
        }
    }
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    CLLocationCoordinate2D centerCoordinate = mapView.region.center;
    
    if (![[ZooCacheManager sharedInstance] mockGPSSwitch]) {
        return;
    }
    [[ZooCacheManager sharedInstance] saveMockCoordinate:centerCoordinate];
    [_mapCenterView hiddenGPSInfo:NO];
    [_mapCenterView renderUIWithGPS:[NSString stringWithFormat:@"%f , %f",centerCoordinate.longitude,centerCoordinate.latitude]];
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:centerCoordinate.latitude longitude:centerCoordinate.longitude];
    [[ZooGPSMocker shareInstance] mockPoint:loc];
}


@end
