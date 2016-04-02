//
//  AQIIndex.h
//  AirMonitor
//
//  Created by 武淅 段 on 16/3/26.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AQIIndex : NSObject


@property (nonatomic) NSString *name;

////污染值
@property (nonatomic, assign) NSInteger level;
//所处等级

@property (nonatomic, assign) NSInteger rank;
//当前等级对应的颜色值
@property (nonatomic) NSString *colorStr;

//各个等级的分界值 4个等级
@property (nonatomic, assign) NSInteger level1;
@property (nonatomic, assign) NSInteger level2;
@property (nonatomic, assign) NSInteger level3;
@property (nonatomic, assign) NSInteger level4;
@property (nonatomic, assign) NSInteger level5;
@property (nonatomic, assign) NSInteger level6;
@property (nonatomic, assign) NSInteger level7;
@property (nonatomic, assign) NSInteger level8;
@property (nonatomic, assign) NSInteger level9;
@property (nonatomic, assign) NSInteger level10;

@end
