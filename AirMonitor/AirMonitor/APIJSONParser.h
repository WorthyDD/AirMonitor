

#import <Foundation/Foundation.h>

@interface APIJSONParser : NSObject

+ (NSString*)stringWithJSONObject:(id)value error:(NSError**)error;
+ (id)objectWithString:(NSString *)jsonStr error:(NSError **)error;

@end
