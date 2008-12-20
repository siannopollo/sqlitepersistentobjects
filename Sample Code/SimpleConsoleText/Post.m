#include "Post.h"

@implementation Post

@synthesize title, text;

DECLARE_PROPERTIES(
	DECLARE_PROPERTY(@"title", @"@\"NSString\""),
	DECLARE_PROPERTY(@"text", @"@\"NSString\"")
)

- (void)dealloc
{
	[title release];
	[text release];
	[super dealloc];
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<Post.%d %@>", [self pk], title];
}

@end
