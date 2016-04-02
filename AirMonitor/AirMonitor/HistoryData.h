//
//  HistoryData.h
//  AirMonitor
//
//  Created by 武淅 段 on 16/3/26.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AQIIndex.h"
#import "AQIIndexCollection.h"

@interface HistoryData : NSObject



/**
 *  generate hour or day data
 */
- (NSArray *) generateDataWithSize : (int)size;

- (NSArray *) generateMonthDataWithSize : (int)size;

@end
