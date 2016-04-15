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

@end
