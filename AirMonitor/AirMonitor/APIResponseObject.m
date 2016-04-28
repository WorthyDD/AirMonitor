

#import "APIResponseObject.h"
#import "NSString+Toolkit.h"

@implementation APIResponseObject

+ (instancetype)objectWithJSONObject:(id)object
{
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *info = object;
        if ([info count]) {
            return [[self alloc] initWithJSONDictionary:object];
        }
    }
    return nil;
}

- (id)JSONObject
{
    NSArray *keys = [[self class] JSONKeys];
    if ([keys count]) {
        NSMutableDictionary *result = [[NSMutableDictionary alloc]init];
        
        NSDictionary *keyMap = [[self class] JSONKeyToPropertyMap];
        for (NSString *key in keys) {
            NSString *realKey = [keyMap valueForKey:key] ?: key;
            id rawObj = [self valueForKey:realKey];
            if ([rawObj respondsToSelector:@selector(JSONObject)]) {
                id jsonObj = [rawObj JSONObject];
                if (jsonObj) {
                    result[key] = jsonObj;
                }
            }
            else {
                if (rawObj) {
                    result[key] = rawObj;
                }
            }
        }
        
        if ([result count]) {
            return result;
        }
    }
    return nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)JSONDictionary
{
    self = [self init];
    if (self) {
        NSMutableArray *initializedProperties = [NSMutableArray array];
        
        NSDictionary *keyMap = [[self class] JSONKeyToPropertyMap];
        NSDictionary *classMap = [[self class] JSONKeyToPropertyClassMap];
        NSDictionary *arrayElementClassMap = [[self class] arrayPropertyElementClassMap];
        
        for (NSString *key in JSONDictionary) {
            NSString *realKey = [keyMap valueForKey:key] ?: key;
            id jsonObj = JSONDictionary[key];
            
            if ([jsonObj isKindOfClass:[NSNull class]]) {
                continue;
            }
            
            [initializedProperties addObject:realKey];
            
            //数组单独处理
            if ([jsonObj isKindOfClass:[NSArray class]]) {
                if ([arrayElementClassMap valueForKey:realKey]) {
                    Class <APIResponseObject> elementClass = NSClassFromString([arrayElementClassMap valueForKey:realKey]);
                    NSMutableArray *tmpArray = [[NSMutableArray alloc]init];
                    for (id subJsonObj in jsonObj) {
                        if ([subJsonObj isKindOfClass:[NSNull class]]) {
                            continue;
                        }
                        id element = [elementClass objectWithJSONObject:subJsonObj];
                        if (element) {
                            [tmpArray addObject:element];
                        }
                    }
                    [self setValue:[NSArray arrayWithArray:tmpArray] forKey:realKey];
                    
                    continue;
                }
            }
            
            //需要做类型映射的单独处理
            if ([classMap valueForKey:key]) {
                Class <APIResponseObject> propertyClass = NSClassFromString([classMap valueForKey:key]);
                id propertyObj = [propertyClass objectWithJSONObject:jsonObj];
                [self setValue:propertyObj forKey:realKey];
                
            }
            else {
                //其它的可以直接赋值
                [self setValue:jsonObj forKey:realKey];
            }
        }        
    }
    return self;
}

+ (NSArray *)JSONKeys
{
    return nil;
}

+ (NSDictionary *)JSONKeyToPropertyClassMap
{
    return nil;
}

+ (NSDictionary *)JSONKeyToPropertyMap
{
    return nil;
}

+ (NSDictionary *)arrayPropertyElementClassMap
{
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

- (NSString *)description
{
    return [[self JSONObject]description];
}

+ (id) pureJsonDictWithObj:(id)obj
{
    if ([obj isKindOfClass:[NSArray class]]) {
        NSMutableArray *resutlArray = [obj mutableCopy];
        for (int i = 0; i < [resutlArray count]; i ++) {
            id item = [resutlArray objectAtIndex:i];
            if ([item isKindOfClass:[NSArray class]] || [item isKindOfClass:[NSDictionary class]]) {
                id result  = [APIResponseObject pureJsonDictWithObj:item];
                [resutlArray replaceObjectAtIndex:i withObject:result];
            }else
                if ([item isKindOfClass:[APIResponseObject class]]) {
                    NSDictionary *dictItem = [item JSONObject];
                    dictItem = [APIResponseObject pureJsonDictWithObj:dictItem];
                    [resutlArray replaceObjectAtIndex:i withObject:dictItem];
                }
        }
        return resutlArray;
    }else if([obj isKindOfClass:[NSDictionary class]]){
        NSMutableDictionary *resultDict = [obj mutableCopy];
        for (NSString *key in resultDict.allKeys) {
            id value = [resultDict valueForKey:key];
            if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
                id result  = [APIResponseObject pureJsonDictWithObj:value];
                [resultDict setValue:result forKey:key];
            }else if ([value isKindOfClass:[APIResponseObject class]]) {
                NSDictionary *dictItem = [value JSONObject];
                dictItem = [APIResponseObject pureJsonDictWithObj:dictItem];
                [resultDict setValue:dictItem forKey:key];
            }
            
            
        }
        return resultDict;
        
    }
    return obj;
}

- (NSString *)debugDescription
{
    return [[self JSONObject]debugDescription];
}

- (BOOL)isEqual:(id)object
{
    if (object == self) {
        return YES;
    }
    
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    return [[self JSONObject] isEqual:[object JSONObject]];
}

- (id)copyWithZone:(NSZone *)zone
{
    return [[self class] objectWithJSONObject:[self JSONObject]];
}

@end

@implementation NSDate (APIResponseObject)

+ (instancetype)objectWithJSONObject:(id)object
{
    if ([object isKindOfClass:[NSNumber class]]) {
        return [NSDate dateWithTimeIntervalSince1970:[(NSNumber *)object doubleValue]];
    }
    else if([object isKindOfClass:[NSString class]]){
        return [NSDate dateFromRFC3339String:object];
    }
    return nil;
}

+ (NSDate *)dateFromRFC3339String:(NSString *)RFC3339String
{
    NSString *dateString = [RFC3339String ta_stringByDeleteCharactersInString:@"Tt "];
    
    static NSString *dateFormat = @"yyyy-MM-dd";
    static NSString *timeFormat = @"HH:mm:ss";
    static NSString *dateTimeFormat = @"yyyy-MM-ddHH:mm:ss";
    
    static NSDateFormatter *formatter;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc]init];
    }
    
    NSInteger length = dateString.length;
    if (length == dateFormat.length) {
        [formatter setDateFormat:dateFormat];
    }
    else if(timeFormat.length == length) {
        [formatter setDateFormat:timeFormat];
    }
    else if(dateTimeFormat.length == length){
        [formatter setDateFormat:dateTimeFormat];
    }
    else {
        return nil;
    }
    
    return [formatter dateFromString:dateString];
}

- (id)JSONObject
{
    return @([self timeIntervalSince1970]);
}

@end

@implementation NSNumber (APIResponseObject)

+ (instancetype)objectWithJSONObject:(id)object
{
    if ([object isKindOfClass:[NSNumber class]]) {
        return object;
    }
    
    if ([object isKindOfClass:[NSString class]]) {
        return @([object integerValue]);
    }
    
    return nil;
}

- (id)JSONObject
{
    return self;
}

@end

@implementation NSString (APIResponseObject)

+ (instancetype)objectWithJSONObject:(id)object
{
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    }
    else {
        return [NSString stringWithFormat:@"%@", object];
    }
}

- (id)JSONObject
{
    return self;
}

@end
