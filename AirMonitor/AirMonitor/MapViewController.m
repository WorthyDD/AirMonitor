//
//  MapViewController.m
//  AirMonitor
//
//  Created by 武淅 段 on 16/4/3.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) CLLocationManager *locationManager;

@property (nonatomic) CLLocationCoordinate2D coordinate;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    _mapView.mapType = MKMapTypeStandard;
    
    [self startLocationService];
}


//定位
- (void) startLocationService
{
    if(!_locationManager){
        _locationManager = [[CLLocationManager alloc]init];
    }

    if(![_locationManager locationServicesEnabled]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"TIP" message:@"Location service is not open, please open it in setting" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    //如果没有授权
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
        [_locationManager requestWhenInUseAuthorization];
       /* _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        
        //每隔100米定位一次
        CLLocationDistance distance = 100;
        _locationManager.distanceFilter = distance;
        [_locationManager startUpdatingLocation];*/
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    
    _coordinate = coordinate;
    //如果不需要实时定位，使用完即使关闭定位服务
//    [_locationManager stopUpdatingLocation];
}


#pragma mark 添加大头针
-(void)addAnnotation{
    
    WXAnnotation *annotation=[[WXAnnotation alloc]init];

    annotation.coordinate=_coordinate;
    [_mapView addAnnotation:annotation];
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if([annotation isKindOfClass:[WXAnnotation class]]){
        
        static NSString *key1=@"AnnotationKey1";
        MKAnnotationView *annotationView=[_mapView dequeueReusableAnnotationViewWithIdentifier:key1];
        //如果缓存池中不存在则新建
        if (!annotationView) {
            annotationView=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:key1];
            annotationView.canShowCallout=true;//允许交互点击
            annotationView.calloutOffset=CGPointMake(0, 1);//定义详情视图偏移量
           // annotationView.leftCalloutAccessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_classify_cafe.png"]];//定义详情左侧视图
        }
        
        //修改大头针视图
        //重新设置此类大头针视图的大头针模型(因为有可能是从缓存池中取出来的，位置是放到缓存池时的位置)
        annotationView.annotation=annotation;
        annotationView.image=((WXAnnotation *)annotation).image;//设置大头针视图的图片
        
        return annotationView;
    }
    
    
    return nil;
}

@end
