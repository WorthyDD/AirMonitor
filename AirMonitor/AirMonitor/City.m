//
//  City.m
//  AirMonitor
//
//  Created by 武淅 段 on 16/3/26.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import "City.h"

@implementation City


- (NSMutableArray *)monitoringStationArray
{
    if(!_monitoringStationArray){
        _monitoringStationArray = [[NSMutableArray alloc]init];
    }
    return _monitoringStationArray;
}
@end
