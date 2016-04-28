//
//  AirQualityViewController.m
//  AirMonitor
//
//  Created by 武淅 段 on 16/3/25.
//  Copyright © 2016年 武淅 段. All rights reserved.
//



//color tab



#import "AirQualityViewController.h"


static NSString *kAddMonitoringStationSegue = @"addMonitorSegue";
@interface AirQualityViewController()


@property (weak, nonatomic) IBOutlet UILabel *mainAQILabel;
@property (weak, nonatomic) IBOutlet UIView *mainAQIView;
@property (weak, nonatomic) IBOutlet UILabel *districtLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *temLabel;
@property (weak, nonatomic) IBOutlet UILabel *pm25Label;
@property (weak, nonatomic) IBOutlet UILabel *pm10Label;
@property (weak, nonatomic) IBOutlet UILabel *o3Label;
@property (weak, nonatomic) IBOutlet UILabel *no2Label;
@property (weak, nonatomic) IBOutlet UILabel *so2Label;
@property (weak, nonatomic) IBOutlet UILabel *pm25TipLabel;
@property (weak, nonatomic) IBOutlet UILabel *pm10TipLabel;
@property (weak, nonatomic) IBOutlet UILabel *o3TipLabel;
@property (weak, nonatomic) IBOutlet UILabel *no2TipLabel;
@property (weak, nonatomic) IBOutlet UILabel *so2TipLabel;



//advice for health





@property (weak, nonatomic) IBOutlet UILabel *adviceTitle1;
@property (weak, nonatomic) IBOutlet UILabel *adviceTitle2;
@property (weak, nonatomic) IBOutlet UILabel *adviceTitle3;
@property (weak, nonatomic) IBOutlet UILabel *adviceSubTitle1;
@property (weak, nonatomic) IBOutlet UILabel *adviceSubTitle2;
@property (weak, nonatomic) IBOutlet UILabel *adviceSubTitle3;


@end

@implementation AirQualityViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *bgImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg"]];
    bgImage.frame = [UIScreen mainScreen].bounds;
    self.tableView.backgroundView = bgImage;
    
    
    
}


- (void) testAPIManager
{
    APIRequest *request = [[APIRequest alloc]initWithAPIPath:@"/AirQuality/Information/Species/Json" method:APIRequestMethodGet];
    APIRequestOperationManager *manager = [APIRequestOperationManager shareManager];
    [manager requestAPI:request comletion:^(id result, NSError *error) {
        
        
        if(error){
            NSLog(@"\n\nerror--> %@",error);
        }
        if(result){
            NSLog(@"\n\n result--> %@", result);
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadData];
}


- (void) reloadData
{
   
    [self.districtLabel setText:_station.name];
        
    //生成污染物指数
    [self.pm25Label setText:[NSString stringWithFormat:@"%ld",_station.PM25.level]];
    [self.pm10Label setText:[NSString stringWithFormat:@"%ld",_station.PM10.level]];
    [self.o3Label setText:[NSString stringWithFormat:@"%ld",_station.O3.level]];
    [self.no2Label setText:[NSString stringWithFormat:@"%ld",_station.NO2.level]];
    [self.so2Label setText:[NSString stringWithFormat:@"%ld",_station.SO2.level]];
    
    //污染物等级
    [self.pm25TipLabel setText:[NSString stringWithFormat:@"Level%ld",_station.PM25.rank]];
    [self.pm10TipLabel setText:[NSString stringWithFormat:@"Level%ld",_station.PM10.rank]];
    [self.o3TipLabel setText:[NSString stringWithFormat:@"Level%ld",_station.O3.rank]];
    [self.no2TipLabel setText:[NSString stringWithFormat:@"Level%ld",_station.NO2.rank]];
    [self.so2TipLabel setText:[NSString stringWithFormat:@"Level%ld",_station.SO2.rank]];
    
    //颜色
    [self.pm25TipLabel setBackgroundColor:[UIColor colorWithHexString:_station.PM25.colorStr]];
    [self.pm10TipLabel setBackgroundColor:[UIColor colorWithHexString:_station.PM10.colorStr]];
    [self.o3TipLabel setBackgroundColor:[UIColor colorWithHexString:_station.O3.colorStr]];
    [self.no2TipLabel setBackgroundColor:[UIColor colorWithHexString:_station.NO2.colorStr]];
    [self.so2TipLabel setBackgroundColor:[UIColor colorWithHexString:_station.SO2.colorStr]];
    
    //主要污染物
    [self.mainAQILabel setText:[NSString stringWithFormat:@"%ld", _station.mainAQI.level]];
    [self.mainAQIView setBackgroundColor:[UIColor colorWithHexString:_station.mainAQI.colorStr]];
    
    if(_station.mainAQI.rank<=6){
        [_adviceSubTitle1 setText:@"Suitable"];
        [_adviceSubTitle2 setText:@"Unnecessary"];
        [_adviceSubTitle3 setText:@"Suitable For Outdoor Activities"];
        
    }
    else{
        
        [_adviceSubTitle1 setText:@"Unsuitable"];
        [_adviceSubTitle2 setText:@"Necessary"];
        [_adviceSubTitle3 setText:@"Unsuitable For Outdoor Activities"];
    }
    
    
    
    //temperature 0-30
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *timeStr = [formatter stringFromDate:date];
    [self.dateLabel setText:[NSString stringWithFormat:@"Update on %@",timeStr]];
    [self.temLabel setText:[NSString stringWithFormat: @"Temperature : %ld°C",_station.temperature]];
    
    
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0? 0.1 : 30;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}


#pragma mark - add city
- (IBAction)didTapAddButton:(id)sender {
    [self performSegueWithIdentifier:kAddMonitoringStationSegue sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:kAddMonitoringStationSegue]){
        
    }
}

@end
