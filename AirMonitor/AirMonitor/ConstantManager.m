//
//  ConstantManager.m
//  AirMonitor
//
//  Created by 武淅 段 on 16/3/26.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import "ConstantManager.h"

@implementation ConstantManager

+ (instancetype)shareManager
{
    static ConstantManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        manager = [[ConstantManager alloc]init];
        
    });
    return manager;
}

- (NSArray *)cityArray
{
    if(!_cityArray){
        _cityArray = [[NSMutableArray alloc]init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cityList" ofType:@"plist"];
        NSArray *cityList = [NSArray arrayWithContentsOfFile:path];
        for(NSDictionary *dic in cityList){
            NSString *name = [dic objectForKey:@"name"];
            NSArray *arr = [dic objectForKey:@"Monitor Point"];
            City *city = [[City alloc]init];
            city.name = name;
            
            for(NSDictionary *statitionDic in arr){
                NSString *stationName = [statitionDic objectForKey:@"name"];
                MonitoringStation *station = [[MonitoringStation alloc]init];
                station.name = stationName;
                [city.monitoringStationArray addObject:station];
            }
            [_cityArray addObject:city];
        }
    }
    return _cityArray;
}

@end
