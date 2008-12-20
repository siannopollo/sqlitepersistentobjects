#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@interface PostCategory : SQLitePersistentObject {
	NSString *title;
}
@property (nonatomic,readwrite,retain) NSString *title;

@end;