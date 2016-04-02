//
//  HistoryData.m
//  AirMonitor
//
//  Created by 武淅 段 on 16/3/26.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import "HistoryData.h"


@interface  HistoryData()

@end
@implementation HistoryData


- (NSArray *)generateDataWithSize:(int)size
{
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    for(int i = 0; i < size;i++){
        
        AQIIndexCollection *collection = [[AQIIndexCollection alloc]init];
        [dataArray addObject:collection];
        
    }
    
    return dataArray;
}

- (NSDictionary *)generateMonthData
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    for(int i = 0; i < 12;i++){
        
        //每个月生成5种污染物所占百分比
        
        
    }
    
    return dic;
}
@end
