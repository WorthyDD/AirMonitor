//
//  HistoryDataViewController.m
//  AirMonitor
//
//  Created by 武淅 段 on 16/3/26.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import "HistoryDataViewController.h"

@interface HistoryDataViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *AQIButtons;     //tag 1-6

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign) NSInteger currentSelectedButtonTag;
@property (weak, nonatomic) IBOutlet DataView *hourView;
@property (weak, nonatomic) IBOutlet DataView *dayView;
@property (weak, nonatomic) IBOutlet DataView *monthView;

@property (nonatomic) HistoryData *data;

@end

@implementation HistoryDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.titleLabel setText:[ConstantManager shareManager].currentStation.name];
}

- (void) initView
{
    _currentSelectedButtonTag = 1;
    _hourView.hidden = NO;
    _dayView.hidden = YES;
    _monthView.hidden = YES;
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
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH"];
    NSString *hourStr = [formatter stringFromDate:now];
    int hour = [hourStr intValue];
    NSArray *hourArray = [_data generateDataWithSize:hour];
    _hourView.dataArray = hourArray;
    
    [formatter setDateFormat:@"dd"];
    NSString *dayStr = [formatter stringFromDate:now];
    int day = [dayStr intValue];
    NSArray *dayArray = [_data generateDataWithSize:day];
    _dayView.dataArray = dayArray;
    
    _hourView.dataType = DataTypeHour;
    _dayView.dataType = DataTypeDay;
    _monthView.dataType = DataTypeMonth;
    _hourView.aqiType = AQI;
    _dayView.aqiType = AQI;
    _monthView.aqiType = AQI;
    
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
}

- (IBAction)didTapRight:(id)sender {
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
