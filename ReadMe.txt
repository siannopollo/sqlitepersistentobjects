SQLite Persistent Objects
Wouldn't it be nice if your Objective-C data objects just knew how to save and load themselves? It'd be nice if you could just call "save" and trust that your object would save itself properly somewhere, and that when you wanted to load it back in, you could just call a class method to retrieve the object or objects you wanted?

Well, now you can. I've been talking about this project for a while, but it got put on hold for the book. I have now finished the first draft of the code. This is very much a beta release, but I am interested in feedback from people, so am releasing it. In the next release, I will provide more sample code and unit tests, and other niceties, but for this release, you just get the source code files and a little bit of information about how to use them.

WHAT DOES IT DO?


It lets you create Objective-C classes that know how to persist themselves into a SQLite database. Not only that, but it completely hides the implementation details from you - you do not need to create the database, create the tables, or do anything else except work with your ojbects. you simply subclass SQLitePersistentObject and create Objective-C 2.0 properties for every data element you want persisted. When you create an instance of this object and send it the save message, it will get saved into the database.

HOW DOES IT WORK


Every subclass of SQLitePersistentObject gets its own table in the database. Every property that's not a collection class (NSDictionary, NSArray, NSSet or mutable variants) will get persisted into a column in the database. Properties that are pointers to other objects that are also subclasses of SQLitePersistentObject will get stored as a reference to the right row in that object's corresponding table. Collection classes gets stored as child tables, and are capable of storing either a foreign key reference (when the object they hold is a subclass of SQLitePersistentObject) or in a field on the child table.

CAN ALL PROPERTIES BE STORED?


No. But most can. This currently does not support properties that are c-strings, void pointers, structs, or unions. All scalars (ints, floats, etc) get saved into appropriate fields. When it comes to Cocoa objects, any class that conforms to NSCoding can be stored in a column. It is also possible to provide support for specific classes by adding a category on the class you wish to support that tells the system how to store and retrieve that object from a column's data. There are provided categories for NSDate, NSString, NSData, NSMutableData, NSNumber, and (of course) NSObject. Creating new ones to let other objects be persisted is relatively easy - just look at one of the included categories and implement the same methods. The methods are documented in NSObject-SQLitePersistence.h.

Classes that don't have direct support (the ones listed above or any that you add), will use NSObject's persistence mechanism, which archives the object into a BLOB using an NSKeyedArchiver. This is inefficient for some objects because you can't search or compare on these fields, but at least most object can be persisted. Some classes like NSImage, this method actually works quite well and there's probably no reason to add a specific category.

HOW DO I USE IT?


Add all the files from the zip file to your project, link in libsqlite3.dylib. Then, declare data objects like this:

#import <foundation/foundation.h>
#import "SQLitePersistentObject.h"

@interface PersistablePerson : SQLitePersistentObject {
 NSString *lastName;
 NSString *firstName;
}
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * firstName;
@end

Once you've done that, you can just create your objects as usual:

PersistablePerson *person = [[PersistablePerson alloc] init];
person.firstName = @"Joe";
person.lastName = @"Smith";

Now, you can save it to the database (which will be created if necessary) like so:

[person save];

Loading it back in is almost as easy. Any persistable object gets dynamic class methods added to it to allow you to search. So, we could retrieve all the PersistablePerson objects that had a last name of "Smith" like so:

NSArray *people = [PersistablePerson findByLastName:@"Smith"]

Or, you could specify the exact criteria like this:

PeristablePerson *joeSmith = [PersistablePerson findFirstByCriteria:@"WHERE last_name = 'Smith' AND first_name = 'Joe'];

Notice that the camel case word divisions (marked by capital letters) got changed into an underscore, so if you want to use findByCriteria: or findFirstByCriteria: you have to make sure you get the column names correct. I plan on adding additional dynamic class methods to allow searching based on multiple criteria, but for now, if you want to search on more than one field you have to manually specify the criteria. Don't worry, it's not hard.
CAN I CREATE INDEXES?


Yep. Just need to override a class method

+(NSArray *)indices;

You should return an NSArray of NSArrays. Each array contained in the returned array represents one index, and should contain the name of the properties to build the index on. Use the property names - although, in some cases, the names are changed, this method should return the actual property names, not the database column names. Here is an example implementation of indices

+(NSArray *)indices
{
 NSArray *index1 = [NSArray arrayWithObject:@"lastName"];
 NSArray *index2 = [NSArray arrayWithObjects:@"lastName", @"firstName", nil];
 NSArray *index3 = [NSArray arrayWithObjects:@"age", @"lastName", @"firstName", nil];
 return [NSArray arrayWithObjects:index1, index2, index3, nil];
}

Assuming the strings passed back all describe valid properties, the table that holds this class' data will have three indices. Easy enough, right?
WHAT HAPPENS IF I LOAD THE SAME OBJECT IN MULTIPLE TIMES?


These classes maintain a map of all persistable objects in memory. If you load one that's already in memory, it returns a reference to that instead of going back to the database. If you need to be able to make a copy of the object, you'll have to implement NSCopying, as SQLitePersistableObject does not currently conform to NSCopying, though it probably will before I consider this "done".
HOW IS THIS LICENSED


It's a very liberal license. You can use it however you want, without attribution, in any software commercial or otherwise. You are not required to contribute back your changes (although they are certainly welcome), nor are you required to distribute your changed version. The only restriction that I place on this is that if you distribute the source code, modified or unmodified, that you leave my original comments, copyright notice, and contact information, and ask that you comment your changes.
IS IT FULLY FUNCTIONAL?


Close to it. As I said earlier, I want to add more robust methods for finding objects. I also haven't implemented rollback. Because this maintains a memory map, it's actually difficult right now to go back to the way an object was when it was last saved because you have to make sure that every object that has a reference to that object releases it, make sure that it is gone, then re-load it from the database. Rollback is high on my priority list. Because this is an early release, there are bound to be bugs and I'm sure you can come up with enhancements that could make it better.
DOES IT USE PRIVATE OR UNDOCUMENTED LIBRARIES?


No. It does not. It does make extensive use of the Objective-C runtime, but that is fully documented and open to developers. There is also nothing in here covered by the NDA. It was developed under Cocoa for OS X, but since it only uses foundation objects, it should, in theory, work just as well on the iPhone. Because of the NDA, I'm not actually going to say it works on the iPhone... I can neither confirm or deny that it works on said platform. But it should.
SO, WHERE IS IT ALREADY?


You can get it right here.

You should check out the file SQLitePersistentObject.h, which contains fairly extensive documentation in headerdoc format.