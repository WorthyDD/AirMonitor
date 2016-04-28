//
//  APIManager.m
//  AirMonitor
//
//  Created by 武淅 段 on 16/4/16.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import "APIManager.h"


@implementation APIManager


+ (APIRequest *)getMonitorSitesListAPI
{
    APIRequest *request = [[APIRequest alloc]initWithAPIPath:@"" method:APIRequestMethodGet];
    return request;
}

+ (APIRequest *)getAQIDataWithSitesCode:(NSInteger)code speciesCode:(NSInteger)speciesCode date:(NSDate *)date
{
    APIRequest *request = [[APIRequest alloc]initWithAPIPath:@"" method:APIRequestMethodGet];
    request.urlQueryParameters = @{@"site_code" : @(code),
                                   @"species_code" : @(speciesCode),
                                   @"date" : date};
    request.resultObjectClass = [AQIIndex class];
    return request;
}

+ (APIRequest *)getAQIDataWithSitesCode:(NSInteger)code speciesCode:(NSInteger)speciesCode fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    APIRequest *request = [[APIRequest alloc]initWithAPIPath:@"" method:APIRequestMethodGet];
    request.urlQueryParameters = @{@"site_code" : @(code),
                                   @"species_code" : @(speciesCode),
                                   @"start" : fromDate,
                                   @"end" : toDate};
    return request;
}


@end
