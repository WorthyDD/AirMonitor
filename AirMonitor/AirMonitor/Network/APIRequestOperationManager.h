//
//  APIRequestOperationManager.h
//  AirMonitor
//
//  Created by 武淅 段 on 16/4/14.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "APIRequest.h"

/**
 *      网络请求管理器
 */
@interface APIRequestOperationManager : AFHTTPSessionManager

+ (instancetype) shareManager;


/**
 *      开始一个网络请求   completion在主线程调用
 */
- (NSURLSessionDataTask *) requestAPI : (APIRequest *)api comletion : (void (^)(id result, NSError *error)) completion;

@end


extern NSString *const kAPIServerHostAddress;
extern NSString *const kAPIRequestOperationManagerErrorInfoMessageKey;
extern NSString *const kAPIRequestOperationManagerErrorInfoServerCodeKey;
extern NSString *const kAPIRequestOperationManagerErrorInfoServerDataKey;