//
//  MonitoringStation.h
//  AirMonitor
//
//  Created by 武淅 段 on 16/3/26.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AQIIndex.h"
#import <MapKit/MapKit.h>

@interface MonitoringStation : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) CLLocationCoordinate2D coordinate;

//污染物指数
@property (nonatomic) AQIIndex *PM25;
@property (nonatomic) AQIIndex *PM10;
@property (nonatomic) AQIIndex *O3;
@property (nonatomic) AQIIndex *NO2;
@property (nonatomic) AQIIndex *SO2;

//最主要污染物
@property (nonatomic) AQIIndex *mainAQI;

//温度
@property (nonatomic, assign) NSInteger temperature;

/**
 * 生成随机的值
 */
- (void) getAQIIndex;

@property (nonatomic, assign) BOOL selected;

@end
