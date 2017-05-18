#import <Foundation/Foundation.h>

@interface KFKeychain : NSObject


+ (BOOL)saveObject:(id)object forKey:(NSString *)key;
+ (id)loadObjectForKey:(NSString *)key;
+ (BOOL)deleteObjectForKey:(NSString *)key;

@end
