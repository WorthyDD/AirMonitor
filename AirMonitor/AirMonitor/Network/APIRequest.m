//
//  APIRequest.m
//  AirMonitor
//
//  Created by 武淅 段 on 16/4/14.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import "APIRequest.h"

@implementation APIRequest

- (instancetype) initWithAPIPath:(NSString *)apiPath method:(APIRequestMethod)method
{
    self = [super init];
    if(self){
        _method = method;
        _apiPath = apiPath;
    }
    return self;
}

@end
