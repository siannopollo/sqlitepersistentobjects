#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@interface PostInvalid : SQLitePersistentObject {
	NSString *text;
}
@property (nonatomic,readwrite,retain) NSString *text;

@end;