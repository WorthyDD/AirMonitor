//
//  APIJSONParser.h
//  wybxg
//
//  Created by Hale Chan on 15/3/13.
//  Copyright (c) 2015年 Tips4app Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIJSONParser : NSObject

+ (NSString*)stringWithJSONObject:(id)value error:(NSError**)error;
+ (id)objectWithString:(NSString *)jsonStr error:(NSError **)error;

@end
