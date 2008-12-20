#include "PostComment.h"

@implementation PostComment

@synthesize title, post;

DECLARE_PROPERTIES(
	DECLARE_PROPERTY(@"title", @"@\"NSString\""),
	DECLARE_PROPERTY(@"post", @"@\"Post\"")
)

- (void)dealloc
{
	[title release];
	[post release];
	[super dealloc];
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<PostComment.%d %@>", [self pk], title];
}

@end
