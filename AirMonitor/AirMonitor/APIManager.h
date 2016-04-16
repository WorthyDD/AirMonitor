//
//  APIManager.h
//  AirMonitor
//
//  Created by 武淅 段 on 16/4/16.
//  Copyright © 2016年 武淅 段. All rights reserved.
//


/**
 *          接口管理类
 *
 */


#import "APIRequest.h"
#import "City.h"
#import "MonitoringStation.h"
#import "AQIIndex.h"
#import "AQIIndexCollection.h"
#import <Foundation/Foundation.h>

@interface APIManager : NSObject


/**
 *  获取监测点列表
 */
+ (APIRequest *) getMonitorSitesListAPI;

/**
 *  获取某个监测点某时刻的AQI数据
 */

+ (APIRequest * ) getAQIDataWithSitesCode : (NSInteger) code speciesCode : (NSInteger )speciesCode date: (NSString *)date;

/**
 *  获取某个时间段的某个AQI的列表
 */
+ (APIRequest * ) getAQIDataWithSitesCode : (NSInteger) code speciesCode : (NSInteger )speciesCode fromDate : (NSString *)fromDate toDate : (NSString *)toDate;
@end
