//
//  APIRequestOperationManager.m
//  AirMonitor
//
//  Created by 武淅 段 on 16/4/14.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import "APIRequestOperationManager.h"


NSString *const kAPIServerHostAddress = @"http://api.erg.kcl.ac.uk";
NSString *const kAPIRequestOperationManagerErrorInfoMessageKey = @"message";
NSString *const kAPIRequestOperationManagerErrorInfoServerCodeKey = @"serverCode";
NSString *const kAPIRequestOperationManagerErrorInfoServerDataKey = @"serverData";

@implementation APIRequestOperationManager

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    static APIRequestOperationManager *manager;
    dispatch_once(&onceToken, ^{
       
        manager = [[APIRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:kAPIServerHostAddress]];
        NSOperationQueue *operationQueue = manager.operationQueue;
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"text/html", @"text/plain", @"text/json"]];
        [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
           
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    [operationQueue setSuspended:NO];
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                default:
                    [operationQueue setSuspended:YES];
                    break;
            }
        }];
        [manager.reachabilityManager startMonitoring];
        
    });
    
    return manager;
}


- (NSURLSessionDataTask *)requestAPI:(APIRequest *)api comletion:(void (^)(id, NSError *))completion
{
    NSURLSessionDataTask *result;
    NSDictionary *postParams = api.postParameters;
    NSDictionary *urlParams = api.urlQueryParameters;
    void (^success) (NSURLSessionDataTask *task, id responseObject) = ^(NSURLSessionDataTask *task, id responseObject){
      
        NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
        if(code != 0){
            NSString *msg = [responseObject valueForKey:@"msg"];
            msg = msg?:@"未知错误";
            if(completion){
                completion(nil, [NSError errorWithDomain:@"" code:101 userInfo:@{kAPIRequestOperationManagerErrorInfoMessageKey : msg,kAPIRequestOperationManagerErrorInfoServerCodeKey: @(code)}]);
            }
        }
        else{
            //成功
            //NSLog(@"\n\n获取网络数据---> %@\n\n", responseObject);
            
            if(completion){
                completion(responseObject ,nil);
            }
            
        }
    };
    
    void (^failure)(NSURLSessionDataTask *task, NSError *error) = ^(NSURLSessionDataTask *task, NSError *error){
      
        if(completion){
            NSString *msg = @"网络故障或者服务器故障";
            completion(nil, [NSError errorWithDomain:@"" code:101 userInfo:@{kAPIRequestOperationManagerErrorInfoMessageKey:msg}]);
        }
    };
    
    switch (api.method) {
        case APIRequestMethodGet:
            result = [self GET:api.apiPath parameters:urlParams progress:nil success:success failure:failure];
            break;
        case APIRequestMethodPost:
            if (api.uploadFilesParameters) {
                
                result = [self POST:api.apiPath parameters:postParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                    for (APIUploadFile *uploadFile in api.uploadFilesParameters) {
                        NSData *data = uploadFile.data;
                        if (!data) {
                            if (uploadFile.filePath) {
                                data = [NSData dataWithContentsOfFile:uploadFile.filePath];
                            }
                        }
                        if (data) {
                            [formData appendPartWithFileData:data name:uploadFile.name fileName:uploadFile.fileName mimeType:uploadFile.mineType];
                        }
                    }
                } progress:nil success:success failure:failure];
            }
            else {
                result = [self POST:api.apiPath parameters:postParams progress:nil success:success failure:failure];
            }
        case APIRequestMethodPut:{
            result = [self PUT:api.apiPath parameters:postParams success:success failure:failure];
        }
            break;
        case APIRequestMethodHead:{
            result = [self HEAD:api.apiPath parameters:urlParams success:^(NSURLSessionDataTask *task){
                if (success) {
                    success(task, nil);
                }
            } failure:failure];
        }
            break;
        case APIRequestMethodPatch:{
            result = [self PATCH:api.apiPath parameters:postParams success:success failure:failure];
        }
            break;
        case APIRequestMethodDelete:{
            result = [self DELETE:api.apiPath parameters:postParams success:success failure:failure];
        }
            break;
        default:
            break;
    }
    
    return result;
}


@end
