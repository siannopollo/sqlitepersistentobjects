#if (TARGET_OS_IPHONE)

@implementation UIImage(SQLitePersistence)
+ (id)objectWithSQLBlobRepresentation:(NSData *)data
{
	
}
- (NSData *)sqlBlobRepresentationOfSelf{
	
}
+ (BOOL)canBeStoredInSQLite
{
	return YES;
}
+ (NSString *)columnTypeForObjectStorage
{
	
}
+ (BOOL)shouldBeStoredInBlob
{
	return YES;
}
@end
#endif