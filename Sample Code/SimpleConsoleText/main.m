#import <Foundation/Foundation.h>
#include <unistd.h>
#include <stdlib.h>
#import "Post.h"
#import "PostCategory.h"
#import "PostComment.h"
#import "PostInvalid.h"
#import "SQLiteInstanceManager.h"

#define LOG(x, ...) { printf([[NSString stringWithFormat:x,##__VA_ARGS__] UTF8String]); printf("\n"); }

void reset_environment()
{
	LOG(@"* Removing DB");
	unlink("test.db");
	[[SQLiteInstanceManager sharedManager] setDatabaseFilepath:@"test.db"];
}

void init_objects()
{
	LOG(@"* Creating test objects");
	Post *p = [[[Post alloc] init] autorelease];
	p.title = @"Test post 1";
	p.text = @"text";
    if ([p existsInDB] == NO) LOG(@"Confirmed not in DB yet");
	[p save];
    if ([p existsInDB] == YES) LOG(@"Confirmed object in DB now");
	p = [[[Post alloc] init] autorelease];
	p.title = @"Test post 2";
	p.text = @"text";
	[p save];
	
	PostCategory *cat = [[[PostCategory alloc] init] autorelease];
	cat.title = @"Category 1";
	[cat save];
	
	PostComment *co = [[[PostComment alloc] init] autorelease];
	co.title = @"Comment 1 to Post 2";
	co.post = p;
	[co save];
    
    PostInvalid *pi = [[[PostInvalid alloc] init] autorelease];
    [pi save];
}

void show_schema()
{
	LOG(@"* DB schema is:");
	system("sqlite3 test.db .schema");
	printf("\n");
}

void show_table(NSString *t)
{
	LOG(@"* Entries in table %@", t);
	system([[NSString stringWithFormat:@"sqlite3 -header -column test.db 'select * from %@'", t] UTF8String]);
	printf("\n");
}

void show_objects(Class cls)
{
	NSArray *a = [cls allObjects];
	LOG(@"* Requested objects for class %@, %d returned:", cls, [a count]);
	for(id *o in a) {
		LOG(@"\t%@", o);
	}
}

void show_related(Class pobj, Class cobj)
{
	LOG(@"* Showing %@ objects related to %@", cobj, pobj);
	NSArray *pp = [pobj allObjects];
	for(SQLitePersistentObject *p in pp) {
		LOG(@"\t%@", p);
		for(SQLitePersistentObject *c in [p findRelated:cobj]) {
			LOG(@"\t\t%@", c);
		}
	}
}

int main(int argc, char *argv[])
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	reset_environment();
	init_objects();
	show_schema();
	show_table(@"post");
	show_table(@"post_comment");
	show_objects([Post class]);
	show_related([Post class], [PostComment class]);
	
	[pool drain];
	return 0;
}
