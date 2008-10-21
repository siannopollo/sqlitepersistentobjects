#if (TARGET_OS_IPHONE)
#import <UIKit/UIKit.h>

@interface UIImage(SQLitePersistence) <SQLitePersistence>
+ (id)objectWithSQLBlobRepresentation:(NSData *)data;
- (NSData *)sqlBlobRepresentationOfSelf;
+ (BOOL)canBeStoredInSQLite;
+ (NSString *)columnTypeForObjectStorage;
+ (BOOL)shouldBeStoredInBlob;
@end
#endif