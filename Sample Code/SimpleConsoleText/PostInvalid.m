#include "PostInvalid.h"

@implementation PostInvalid

@synthesize text;

- (id) init
{
    // invalid init, to trigger the assertion in SQLitePersistentObject
    return self;
}

@end
