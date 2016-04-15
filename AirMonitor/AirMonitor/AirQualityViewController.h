//
//  AirQualityViewController.h
//  AirMonitor
//
//  Created by 武淅 段 on 16/3/25.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstantManager.h"
#import "Tool.h"
#import "APIRequest.h"
#import "APIRequestOperationManager.h"

@interface AirQualityViewController : UITableViewController


@property (nonatomic) MonitoringStation *station;
@end