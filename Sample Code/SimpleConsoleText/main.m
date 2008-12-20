#import <Foundation/Foundation.h>
#include <unistd.h>
#include <stdlib.h>
#import "Post.h"
#import "PostCategory.h"
#import "SQLiteInstanceManager.h"

void reset_environment()
{
	NSLog(@"* Removing DB");
	unlink("test.db");
	[[SQLiteInstanceManager sharedManager] setDatabaseFilepath:@"test.db"];
}

void init_objects()
{
	NSLog(@"* Creating test objects");
	Post *p = [[Post alloc] init];
	p.title = @"Test post 1";
	p.text = @"text";
	[p save];
	p = [[Post alloc] init];
	p.title = @"Test post 2";
	p.text = @"text";
	[p save];
	PostCategory *c = [[PostCategory alloc] init];
	c.title = @"Category 1";
	[c save];
}

void show_schema()
{
	NSLog(@"DB scema is:");
	system("sqlite3 test.db .schema");
}

int main(int argc, char *argv[])
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	reset_environment();
	init_objects();
	show_schema();
	
	[pool drain];
	return 0;
}
