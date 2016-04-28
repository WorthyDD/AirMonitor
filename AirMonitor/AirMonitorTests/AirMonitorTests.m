//
//  AirMonitorTests.m
//  AirMonitorTests
//
//  Created by 武淅 段 on 16/3/25.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "APIRequest.h"
#import "APIRequestOperationManager.h"
#import "APIManager.h"
#import "MonitoringStation.h"
#import "ConstantManager.h"

@interface AirMonitorTests : XCTestCase

@end

@implementation AirMonitorTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        
    }];
}



// 网络接口测试

- (void) testAPIRequest
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

- (void) testSiteListAPI
{
    APIRequest *request = [APIManager getMonitorSitesListAPI];
    [[APIRequestOperationManager shareManager] requestAPI:request comletion:^(id result, NSError *error) {
        if(error){
            NSLog(@"\n\nerror--> %@",error);
        }
        if(result){
            NSLog(@"\n\n result--> %@", result);
        }
    }];
}

- (void) testAQIList
{
    APIRequest *request = [APIManager getAQIDataWithSitesCode:201 speciesCode:12 date:@"2015-12-03"];
    [[APIRequestOperationManager shareManager] requestAPI:request comletion:^(id result, NSError *error) {
        if(error){
            NSLog(@"\n\nerror--> %@",error);
        }
        if(result){
            NSLog(@"\n\n result--> %@", result);
        }
    }];
}

- (void) testAQIList2
{
    APIRequest *request = [APIManager getAQIDataWithSitesCode:23 speciesCode:12 fromDate:@"2015-12-03" toDate:@"2016-04-12"];
    [[APIRequestOperationManager shareManager] requestAPI:request comletion:^(id result, NSError *error) {
        if(error){
            NSLog(@"\n\nerror--> %@",error);
        }
        if(result){
            NSLog(@"\n\n result--> %@", result);
        }
    }];
}


- (void) testGenerateData{
    
    MonitoringStation *station = [[MonitoringStation alloc]init];
    [station getAQIIndex];
}

- (void) testSitesListAPI
{
    [[ConstantManager shareManager] reloadMonitorList];
    NSArray *arr = [ConstantManager shareManager].cityArray;
}


@end
