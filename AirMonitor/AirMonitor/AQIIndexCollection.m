//
//  AQIIndexCollection.m
//  AirMonitor
//
//  Created by 武淅 段 on 16/3/27.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import "AQIIndexCollection.h"

@implementation AQIIndexCollection


- (instancetype)init
{
    self = [super init];
    if(self){
        if(!_PM25){
            _PM25 = [[AQIIndex alloc]init];
            _PM25.name = @"PM2.5";
            _PM25.level1 = 11;
            _PM25.level2 = 23;
            _PM25.level3 = 35;
            _PM25.level4 = 41;
            _PM25.level5 = 47;
            _PM25.level6 = 53;
            _PM25.level7 = 58;
            _PM25.level8 = 64;
            _PM25.level9 = 70;
            _PM25.level10 = 80;
            
        }
        if(!_PM10){
            _PM10 = [[AQIIndex alloc]init];
            _PM10.name = @"PM10";
            _PM10.level1 = 16;
            _PM10.level2 = 33;
            _PM10.level3 = 50;
            _PM10.level4 = 58;
            _PM10.level5 = 66;
            _PM10.level6 = 75;
            _PM10.level7 = 83;
            _PM10.level8 = 91;
            _PM10.level9 = 100;
            _PM10.level10 = 120;
        }
        if(!_O3){
            _O3 = [[AQIIndex alloc]init];
            _O3.name = @"Ozone";
            _O3.level1 = 33;
            _O3.level2 = 66;
            _O3.level3 = 100;
            _O3.level4 = 120;
            _O3.level5 = 140;
            _O3.level6 = 160;
            _O3.level7 = 187;
            _O3.level8 = 213;
            _O3.level9 = 240;
            _O3.level10 = 260;
        }
        if(!_NO2){
            _NO2 = [[AQIIndex alloc]init];
            _NO2.name = @"Nitrogen dioxide";
            _NO2.level1 = 67;
            _NO2.level2 = 134;
            _NO2.level3 = 200;
            _NO2.level4 = 267;
            _NO2.level5 = 334;
            _NO2.level6 = 400;
            _NO2.level7 = 467;
            _NO2.level8 = 534;
            _NO2.level9 = 600;
            _NO2.level10 = 650;
        }
        if(!_SO2){
            _SO2 = [[AQIIndex alloc]init];
            _SO2.name = @"Sulphur dioxide";
            _SO2.level1 = 88;
            _SO2.level2 = 177;
            _SO2.level3 = 266;
            _SO2.level4 = 354;
            _SO2.level5 = 443;
            _SO2.level6 = 532;
            _SO2.level7 = 710;
            _SO2.level8 = 887;
            _SO2.level9 = 1064;
            _SO2.level10 = 1200;
        }
        
        _PM25.level = arc4random()%_PM25.level10;
        _PM10.level = arc4random()%_PM10.level10;
        _O3.level = arc4random()%_O3.level10;
        _NO2.level = arc4random()%_NO2.level10;
        _SO2.level = arc4random()%_SO2.level10;
        
        
        _mainAQI = _PM25;
        if(_mainAQI.level<_PM10.level){
            _mainAQI = _PM10;
        }
        if(_mainAQI.level<_O3.level){
            _mainAQI = _O3;
        }
        if(_mainAQI.level<_NO2.level){
            _mainAQI = _NO2;
        }
        if(_mainAQI.level < _SO2.level){
            _mainAQI = _SO2;
        }
        
    }
    return self;
}

@end
