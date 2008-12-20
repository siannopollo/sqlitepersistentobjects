#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@class Post;

@interface PostComment : SQLitePersistentObject {
	NSString *title;
	Post *post;
}
@property (nonatomic,readwrite,retain) NSString *title;
@property (nonatomic,readwrite,retain) Post *post;

@end;