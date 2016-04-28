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
                double latitude = ((NSNumber *)[statitionDic objectForKey:@"latitude"]).doubleValue;
                double longitude = ((NSNumber *)[statitionDic objectForKey:@"longitude"]).doubleValue;

                MonitoringStation *station = [[MonitoringStation alloc]init];
                station.name = stationName;
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
                station.coordinate = coordinate;
                [city.monitoringStationArray addObject:station];
            }
            [_cityArray addObject:city];
        }
    }
    return _cityArray;
}


- (void)reloadMonitorList
{
    APIRequest *request = [APIManager getMonitorSitesListAPI];
    APIRequestOperationManager *manager = [APIRequestOperationManager shareManager];
    [manager requestAPI:request comletion:^(id result, NSError *error) {
        
        
        if(error){
            NSLog(@"\n\nerror--> %@",error);
        }
        if(result){
            NSLog(@"\n\n result--> %@", result);
            
            NSArray *monitorList = result;
        }
    }];
}

@end
