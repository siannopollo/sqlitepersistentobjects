#include "Post.h"

@implementation Post

@synthesize title, text, transientBit;

DECLARE_PROPERTIES(
	DECLARE_PROPERTY(@"title", @"@\"NSString\""),
	DECLARE_PROPERTY(@"text", @"@\"NSString\"")
)

+(NSArray *)transients
{
	return [NSArray arrayWithObject:@"transientBit"];
}

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
