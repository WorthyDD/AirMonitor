//
//  HistoryDataViewController.m
//  AirMonitor
//
//  Created by 武淅 段 on 16/3/26.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import "HistoryDataViewController.h"

@interface HistoryDataViewController ()<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *AQIButtons;     //tag 1-6

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign) NSInteger currentSelectedButtonTag;
@property (weak, nonatomic) IBOutlet DataView *hourView;
@property (weak, nonatomic) IBOutlet DataView *dayView;
@property (weak, nonatomic) IBOutlet DataView *monthView;
@property (weak, nonatomic) IBOutlet UIButton *lastButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (nonatomic) NSDate *now;
@property (nonatomic) NSDate *hourDate;
@property (nonatomic) NSDate *dayDate;
@property (nonatomic) NSDate *monthDate;

@property (nonatomic) HistoryData *data;
@property (nonatomic) NSMutableArray *sitesArray;
@property (nonatomic) MonitoringStation *currentSite;

@end

@implementation HistoryDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self initData];
   _sitesArray = [[NSMutableArray alloc]init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_sitesArray removeAllObjects];
    for(City *city in [ConstantManager shareManager].cityArray){
        for(MonitoringStation *station in city.monitoringStationArray){
            if(station.selected){
                [_sitesArray addObject:station];
            }
        }
    }
    if(_sitesArray.count == 0){
        [self setTitle:@""];
        return;
    }
    if(!_currentSite || ![_sitesArray containsObject:_currentSite]){
        _currentSite = [_sitesArray firstObject];
        [self initData];
    }
    [self.titleLabel setText:_currentSite.name];
    NSInteger days = [_now daysSinceDay:_hourDate];
    _now = [NSDate date];
    _hourDate = [_now dayByAddingDays:-days];

    
}

- (void) initView
{
    _currentSelectedButtonTag = 1;
    _hourView.hidden = NO;
    _dayView.hidden = YES;
    _monthView.hidden = YES;
    _hourView.dataType = DataTypeHour;
    _dayView.dataType = DataTypeDay;
    _monthView.dataType = DataTypeMonth;
    _hourView.aqiType = AQI;
    _dayView.aqiType = AQI;
    _monthView.aqiType = AQI;
    [self refreshButtons];
}

- (void) refreshButtons
{
    for(UIButton *button in _AQIButtons){
        if(_currentSelectedButtonTag == button.tag){
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor whiteColor]];
        }
        else{
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor clearColor]];
        }
    }
}

- (void) initData{
    
    if(!_data){
        _data = [[HistoryData alloc]init];
    }
    
    
    
    NSDate *now = [NSDate date];
    _now =now;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH"];
    NSString *hourStr = [formatter stringFromDate:now];
    int hour = [hourStr intValue];
    NSArray *hourArray = [_data generateDataWithSize:hour];
    _hourView.dataArray = hourArray;
    
//    NSString *dayStr = [formatter stringFromDate:now];
    int day = (int)now.day;
    NSArray *dayArray = [_data generateDataWithSize:day-1];
    _dayView.dataArray = dayArray;
    
    [formatter setDateFormat:@"MM"];
    NSString *monthStr = [formatter stringFromDate:now];
    int month = [monthStr intValue];
    NSArray *monthArray = [_data generateMonthDataWithSize:month-1];
    _monthView.monthArray = monthArray;
    

    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    _hourDate = now;
    _dayDate = now;
    _monthDate = now;
    NSString *hourDate = [formatter stringFromDate:now];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString *dayDate = [formatter stringFromDate:now];
    [formatter setDateFormat:@"yyyy"];
    NSString *monthDate = [formatter stringFromDate:now];
    
    _hourView.dateString = hourDate;
    _dayView.dateString = dayDate;
    _monthView.dateString = monthDate;
}


- (IBAction)segmentValueChange:(UISegmentedControl *)sender {
    NSLog(@"segment change %ld", sender.selectedSegmentIndex);

    _hourView.hidden = sender.selectedSegmentIndex != 0;
    _dayView.hidden = sender.selectedSegmentIndex != 1;
    _monthView.hidden  = sender.selectedSegmentIndex != 2;
}


- (IBAction)didTapAQIButton:(UIButton *)sender {
    
    NSLog(@"tap button %ld",sender.tag);
    _currentSelectedButtonTag = sender.tag;
    [self refreshButtons];
    
    if(_segmentControl.selectedSegmentIndex == 0){
        
        _hourView.aqiType = (AQIType)sender.tag;
    }
    else if(_segmentControl.selectedSegmentIndex == 1){

        _dayView.aqiType = (AQIType)sender.tag;
    }
    else{
        
    }
}

- (IBAction)didTapLeft:(id)sender {
    
    if(_segmentControl.selectedSegmentIndex == 0){
        
        _hourDate =[_hourDate dayByAddingDays:-1];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *hourDate = [formatter stringFromDate:_hourDate];
        _hourView.dateString = hourDate;
        NSArray *arr = [_data generateDataWithSize:24];
        _hourView.dataArray = arr;
    }
    else if(_segmentControl.selectedSegmentIndex == 1){
        _dayDate =[_dayDate dayByAddingMonths:-1];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM"];
        NSString *dayDate = [formatter stringFromDate:_dayDate];
        _dayView.dateString = dayDate;
        int days = [self getDaysOfMonth:_dayDate];
        NSArray *arr = [_data generateDataWithSize:days];
        _dayView.dataArray = arr;
    }
    else{
        _monthDate =[_monthDate dayByAddingYears:-1];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy"];
        NSString *monthDate = [formatter stringFromDate:_monthDate];
        _monthView.dateString = monthDate;
        NSArray *arr = [_data generateMonthDataWithSize:12];
        _monthView.monthArray = arr;
    }
        
}

- (IBAction)didTapRight:(id)sender {
    
    
    if(_segmentControl.selectedSegmentIndex == 0){
        
        _hourDate =[_hourDate dayByAddingDays:1];
        if([_hourDate compareWithDay:_now] == NSOrderedDescending){
            _hourDate =[_hourDate dayByAddingDays:-1];
            return;
        }
        int size;
        if(_hourDate.day == _now.day){
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"hh"];
            NSString *hourStr = [formatter stringFromDate:_hourDate];
            size = [hourStr intValue];
        }
        else{
            size = 24;
        }
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *hourDate = [formatter stringFromDate:_hourDate];
        _hourView.dateString = hourDate;
        NSArray *arr = [_data generateDataWithSize:size];
        _hourView.dataArray = arr;
    }
    else if(_segmentControl.selectedSegmentIndex == 1){
        _dayDate =[_dayDate dayByAddingMonths:1];
        if([_dayDate compareWithDay:_now] == NSOrderedDescending){
            _dayDate =[_dayDate dayByAddingMonths:-1];
            return;
        }
        
        int size;
        if(_dayDate.month == _now.month){
            size = (int)_dayDate.day;
        }
        else{
            size = [self getDaysOfMonth:_dayDate];
        }
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM"];
        NSString *dayDate = [formatter stringFromDate:_dayDate];
        _dayView.dateString = dayDate;
//        int days = [self getDaysOfMonth:_dayDate];
        NSArray *arr = [_data generateDataWithSize:size-1];
        _dayView.dataArray = arr;
    }
    else{
        _monthDate =[_monthDate dayByAddingYears:1];
        if([_monthDate compareWithDay:_now] == NSOrderedDescending){
            _monthDate =[_monthDate dayByAddingYears:-1];
            return;
        }
        int size;
        if(_monthDate.year == _now.year){
            size = (int)_monthDate.month-1;
        }
        else{
            size = 12;
        }
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy"];
        NSString *monthDate = [formatter stringFromDate:_monthDate];
        _monthView.dateString = monthDate;
        NSArray *arr = [_data generateMonthDataWithSize:size];
        _monthView.monthArray = arr;
    }
}

// 得到某月的天数
- (int) getDaysOfMonth : (NSDate *)date
{
    NSInteger month = date.month;
    NSInteger year = date.year;
    if((month == 1)||(month == 3)||(month == 5)||(month == 7)||(month == 8)||(month == 10)||(month == 12))
        return 31;
    if((month == 4)||(month == 6)||(month == 9)||(month == 11))
        return 30;
    if((year%4 == 1)||(year%4 == 2)||(year%4 == 3))
    {
        return 28;
    }
    if(year%400 == 0)
        return 29;
    if(year%100 == 0)
        return 28;
    return 29;
}



- (IBAction)tapSwitchSiteButton:(id)sender {
    
    if(_sitesArray.count==0){
        return;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Switch Site" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    __weak typeof (self) weakSelf = self;
    for(MonitoringStation *site in _sitesArray){
        [alert addAction:[UIAlertAction actionWithTitle:site.name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.currentSite = site;
            [weakSelf.titleLabel setText:site.name];
            [weakSelf initData];
        }]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
