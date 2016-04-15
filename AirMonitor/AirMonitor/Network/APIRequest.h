//
//  APIRequest.h
//  AirMonitor
//
//  Created by 武淅 段 on 16/4/14.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, APIRequestMethod) {
    APIRequestMethodGet,
    APIRequestMethodHead,
    APIRequestMethodPost,
    APIRequestMethodPut,
    APIRequestMethodPatch,
    APIRequestMethodDelete
};

@interface APIRequest : NSObject

/**
 *  请求方式
 */
@property (nonatomic) APIRequestMethod method;

/**
 *  API路径
 */
@property (nonatomic, copy) NSString *apiPath;

/**
 *  URL 参数
 */
@property (nonatomic, copy) NSDictionary *urlQueryParameters;

/**
 *  POST 参数
 */
@property (nonatomic, copy) NSDictionary *postParameters;

/**
 *  上传文件参数，格式如下:
 *  [
 *      name: APIUploadFile,
 *      ...
 *  ]
 */
@property (nonatomic, strong) NSArray *uploadFilesParameters;

/**
 *  初始化一个request
 */

- (instancetype) initWithAPIPath : (NSString *) apiPath method : (APIRequestMethod) method;

@end

@interface APIUploadFile : NSObject

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *fileName;

/**
 *  在表单中的名字
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件数据，如果data != nil，那么忽略fileURL
 */
@property (nonatomic, strong) NSData *data;

/**
 *  文件路径，仅当不指定data时才使用此属性
 */
@property (nonatomic, copy) NSString *filePath;

/**
 *  MINE类型，如果不指定，则根据fileName和fileURL推断
 */
@property (nonatomic, copy) NSString *mineType;

- (instancetype)initWithFilePath:(NSString *)filePath;
- (instancetype)initWithName:(NSString *)name fileName:(NSString *)fileName data:(NSData *)data mineType:(NSString *)mineType;

@end
