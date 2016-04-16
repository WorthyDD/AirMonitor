//
//  MainPageTableViewController.m
//  AirMonitor
//
//  Created by 武淅 段 on 16/4/15.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import "MainPageTableViewController.h"
#import "CityCell.h"
#import "City.h"
#import "MonitoringStation.h"
#import "ConstantManager.h"

NSString *const kMySitesArray = @"my_sites_array";
@interface MainPageTableViewController ()

@property (nonatomic) NSMutableArray *sitesArray;
@property (nonatomic) NSArray *cityArray;

@end

@implementation MainPageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *bgImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg"]];
    bgImage.frame = [UIScreen mainScreen].bounds;
    self.tableView.backgroundView = bgImage;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillTerminite:) name:@"appWillTerminite" object:nil];
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
    
    [self.tableView reloadData];
}


- (void) appWillTerminite : (NSNotification *)notification
{
    
    NSLog(@"\n\napp will terminite--> %@",_sitesArray);
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for(MonitoringStation *station in _sitesArray){
        [arr addObject:station.name];
    }
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:kMySitesArray];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _sitesArray.count;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    MonitoringStation *station = _sitesArray[indexPath.row];
    [cell.nameLabel setText:station.name];
    [cell.AQILabel setText:[NSString stringWithFormat:@"%ld", station.mainAQI.level]];
    [cell.PM25Label setText:[NSString stringWithFormat:@"PM2.5 %ld", station.PM25.level]];
    [cell.PM10Label setText:[NSString stringWithFormat:@"PM10 %ld", station.PM10.level]];
    [cell.O3Label setText:[NSString stringWithFormat:@"O3 %ld", station.O3.level]];
    [cell.NO2Label setText:[NSString stringWithFormat:@"NO2 %ld", station.NO2.level]];
    [cell.SO2Label setText:[NSString stringWithFormat:@"SO2 %ld", station.SO2.level]];
    
    if(station.mainAQI.rank<=3){
        [cell.tipLabel setText:@"  Good  "];
    }
    else if(station.mainAQI.rank<=6){
        [cell.tipLabel setText:@"  Lightly Polluted  "];
    }
    else if(station.mainAQI.rank<=9){
        [cell.tipLabel setText:@"  Moderately Polluted  "];
    }
    else{
        [cell.tipLabel setText:@"  Heavy Polluted  "];
    }
    
    [cell.tipLabel setBackgroundColor:[UIColor colorWithHexString:station.mainAQI.colorStr]];
    [cell.tipLabel sizeToFit];
    [cell.temperatureLabel setText:[NSString stringWithFormat:@"%ldºC", station.temperature]];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        MonitoringStation *station = _sitesArray[indexPath.row];
        station.selected = NO;
        [_sitesArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MonitoringStation *station = _sitesArray[indexPath.row];
    [self performSegueWithIdentifier:@"detail" sender:station];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
    if([segue.identifier isEqualToString:@"detail"]){
        
        AirQualityViewController *airVC = segue.destinationViewController;
        airVC.station = sender;
        
    }
}


@end
