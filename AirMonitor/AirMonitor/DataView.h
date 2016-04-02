//
//  DataView.h
//  AirMonitor
//
//  Created by 武淅 段 on 16/3/26.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AQIIndex.h"
#import "AQIIndexCollection.h"
#import "HistoryData.h"
#import "Tool.h"

typedef enum{
    
    DataTypeHour,
    DataTypeDay,
    DataTypeMonth
} DataType;

typedef enum{
    AQI  = 1,
    PM25,
    PM10,
    O3,
    NO2,
    SO2
}AQIType;

@interface DataView : UIView

@property (nonatomic, assign) DataType dataType;
@property (nonatomic, assign) AQIType aqiType;

// hour day
@property (nonatomic) NSArray *dataArray;

@end
