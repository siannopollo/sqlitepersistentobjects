#include "PostCategory.h"

@implementation PostCategory

@synthesize title;

DECLARE_PROPERTIES(
	DECLARE_PROPERTY(@"title", @"@\"NSString\"")
)

- (void)dealloc
{
	[title release];
	[super dealloc];
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<PostCategory.%d %@>", [self pk], title];
}

@end
