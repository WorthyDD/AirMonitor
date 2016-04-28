//
//  MonitoringStation.m
//  AirMonitor
//
//  Created by 武淅 段 on 16/3/26.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import "MonitoringStation.h"

@implementation MonitoringStation

- (instancetype)init
{
    self = [super init];
    if(self){
        [self getAQIIndex];
    }
    return self;
}

- (void)getAQIIndex
{
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
    
    
    _NO2.averageLavel = 94;         //25  500
    _PM25.averageLavel = 30;        //10  80
    _PM10.averageLavel =  30;       //10, 80
    _O3.averageLavel = 90;          // 30   200
    _SO2.averageLavel = 180;        //30    800
    
    int tem = arc4random()%100;
    if(tem <= 10){
        _PM25.level = _PM25.averageLavel - 10 - arc4random()%20;
        _PM10.level = _PM10.averageLavel-10-arc4random()%20;
        _O3.level = _O3.averageLavel - 30- arc4random()%30;
        _NO2.level = _NO2.averageLavel- 30-arc4random()%30;
        _SO2.level = _SO2.averageLavel- 80- arc4random()%30;
    }
    else if(tem <= 30){
        _PM25.level = _PM25.averageLavel - 20 + arc4random()%20;
        _PM10.level = _PM10.averageLavel-20+arc4random()%20;
        _O3.level = _O3.averageLavel - 30+arc4random()%30;
        _NO2.level = _NO2.averageLavel- 30+arc4random()%30;
        _SO2.level = _SO2.averageLavel- 80+ arc4random()%80;
    }
    else if(tem <= 70){
        _PM25.level = _PM25.averageLavel + arc4random()%20;
        _PM10.level = _PM10.averageLavel+arc4random()%20;
        _O3.level = _O3.averageLavel + arc4random()%30;
        _NO2.level = _NO2.averageLavel+arc4random()%30;
        _SO2.level = _SO2.averageLavel+arc4random()%80;
    }
    else if(tem <= 90){
        _PM25.level = _PM25.averageLavel + 10 +arc4random()%20;
        _PM10.level = _PM10.averageLavel+10 +arc4random()%20;
        _O3.level = _O3.averageLavel + 30 + arc4random()%30;
        _NO2.level = _NO2.averageLavel+30 +arc4random()%30;
        _SO2.level = _SO2.averageLavel+80 +arc4random()%80;
    }
    else{
        _PM25.level = _PM25.averageLavel + 30 +arc4random()%20;
        _PM10.level = _PM10.averageLavel+30 +arc4random()%20;
        _O3.level = _O3.averageLavel + 50 + arc4random()%30;
        _NO2.level = _NO2.averageLavel+60 +arc4random()%30;
        _SO2.level = _SO2.averageLavel+100 +arc4random()%50;
    }
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
    
    _temperature = 15+arc4random()%10;
    
}

@end
