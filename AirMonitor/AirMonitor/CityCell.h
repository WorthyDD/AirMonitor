//
//  CityCell.h
//  AirMonitor
//
//  Created by 武淅 段 on 16/4/15.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *AQILabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *PM25Label;
@property (weak, nonatomic) IBOutlet UILabel *PM10Label;
@property (weak, nonatomic) IBOutlet UILabel *O3Label;
@property (weak, nonatomic) IBOutlet UILabel *NO2Label;
@property (weak, nonatomic) IBOutlet UILabel *SO2Label;


@end
