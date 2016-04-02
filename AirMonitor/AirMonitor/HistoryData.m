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

- (NSArray *)generateMonthDataWithSize:(int)size
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for(int i = 0; i < size;i++){
        
        //每个月生成5种污染物所占百分比
        int a = arc4random()%100;
        int left = 100-a;
        int b = arc4random()%left;
        left -= b;
        int c = arc4random()%left;
        left -= c;
        int d = left;
        
        [arr addObject:@(a)];
        [arr addObject:@(b)];
        [arr addObject:@(c)];
        [arr addObject:@(d)];
    }
    
    return arr;
}
@end
