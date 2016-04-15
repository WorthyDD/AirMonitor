//
//  APIObject.h
//  PersonalTravel
//
//  Created by Hale Chan on 15/1/26.
//  Copyright (c) 2015年 Tips4app Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APIResponseObject <NSObject>

@required
/**
 *  由日历网络接口返回的对象生成一个Local对象
 *
 *  @param object 网络接口返回的对象，一般是JSON串转化而来，顶级对象通常是一个字典
 *
 *  @return 一个Local对象
 */
+ (instancetype)objectWithJSONObject:(id)object;

/**
 *  由Local对象生成一个JSON对象，即[objectWithJSONObject:]的逆过程
 *
 *  @return 一个还JSON未序列化的对象
 */
- (id)JSONObject;
@end

@interface APIResponseObject : NSObject <APIResponseObject>

/**
 *  由JSON字典初始化一个对象实例
 *
 *  @param info 一个字典
 *
 *  @return 初始化的对象实例
 */
- (instancetype)initWithJSONDictionary:(NSDictionary *)info;

+ (id) pureJsonDictWithObj:(id)obj;

/**
 *  JSON对象的key到Local对象的property的映射表
 *
 *  @return 一个表示JSON对象的key到Local对象的property的映射表
 */
+ (NSDictionary *)JSONKeyToPropertyMap;

/**
 *  JSON对象的key到Local对象的property类型映射表
 *
 *  @return 一个表示JSON对象的key到Local对象的property类型映射表
 */
+ (NSDictionary *)JSONKeyToPropertyClassMap;

/**
 *  JSON对象支持的全部的key
 *
 *  @return 表示全部key的数组
 */
+ (NSArray *)JSONKeys;

/**
 *  在解析JSON对象时，如果某个子对象是一个数组，且对应的property的类型为数组，则需要确定该数组的元素的类型
 *
 *  @notice 返回的结果的格式如下
 *  {
 *      propertyName1 : className1,
 *      propertyName2 : className2,
 *      ...
 *  }
 *  上面的class应该支持APIResponseObject协议
 *
 *  @return 表示数组property的元素的类型的字典
 */
+ (NSDictionary *)arrayPropertyElementClassMap;


@end

@interface NSDate (APIResponseObject) <APIResponseObject>
@end

@interface NSString (APIResponseObject) <APIResponseObject>

@end

@interface NSNumber (APIResponseObject)<APIResponseObject>

@end
