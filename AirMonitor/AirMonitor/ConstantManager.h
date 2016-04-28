//
//  ConstantManager.h
//  AirMonitor
//
//  Created by 武淅 段 on 16/3/26.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "City.h"
#import "MonitoringStation.h"
#import "APIManager.h"
#import "APIRequestOperationManager.h"

@interface ConstantManager : NSObject


+ (instancetype) shareManager;

- (void)reloadMonitorList;

/**
 *  city & monitoring station list
 */
@property (nonatomic) NSMutableArray *cityArray;
@property (nonatomic) City *currentCity;
@property (nonatomic) MonitoringStation *currentStation;



@end
