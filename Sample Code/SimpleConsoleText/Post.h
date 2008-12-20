#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@interface Post : SQLitePersistentObject {
	NSString *title;
	NSString *text;
}
@property (nonatomic,readwrite,retain) NSString *title;
@property (nonatomic,readwrite,retain) NSString *text;

@end;