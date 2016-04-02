//
//  AQIIndexCollection.h
//  AirMonitor
//
//  Created by 武淅 段 on 16/3/27.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AQIIndex.h"


@interface AQIIndexCollection : NSObject

//污染物指数
@property (nonatomic) AQIIndex *PM25;
@property (nonatomic) AQIIndex *PM10;
@property (nonatomic) AQIIndex *O3;
@property (nonatomic) AQIIndex *NO2;
@property (nonatomic) AQIIndex *SO2;

//最主要污染物
@property (nonatomic) AQIIndex *mainAQI;

@end
