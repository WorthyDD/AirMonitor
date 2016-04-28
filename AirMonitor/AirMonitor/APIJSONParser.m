

#import "APIJSONParser.h"

@implementation APIJSONParser

+ (NSString*)stringWithJSONObject:(id)value error:(NSError**)error
{
    if (nil == value) {
        return nil;
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:value options:0 error:error];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

+ (id)objectWithString:(NSString *)jsonStr error:(NSError **)error
{
    if (nil == jsonStr) {
        return nil;
    }
    
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
}

@end
