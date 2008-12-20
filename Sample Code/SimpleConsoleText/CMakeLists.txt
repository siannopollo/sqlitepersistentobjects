PROJECT(ConsoleTest)

CMAKE_MINIMUM_REQUIRED(VERSION 2.6)

IF(APPLE)
	SET(OBJC_LIBS objc "-framework Foundation")
ELSE(APPLE) # i.e. Cocotron
	SET(OBJC_LIBS Foundation dl pthread)
ENDIF(APPLE)

SET(SQLitePersistentObject_sources
	${ConsoleTest_SOURCE_DIR}/../../src/NSData-SQLitePersistence.m
	${ConsoleTest_SOURCE_DIR}/../../src/NSDate-SQLitePersistence.m
	${ConsoleTest_SOURCE_DIR}/../../src/NSMutableData-SQLitePersistence.m
	${ConsoleTest_SOURCE_DIR}/../../src/NSNumber-SQLitePersistence.m
	${ConsoleTest_SOURCE_DIR}/../../src/NSObject-SQLitePersistence.m
	${ConsoleTest_SOURCE_DIR}/../../src/NSString-NumberStuff.m
	${ConsoleTest_SOURCE_DIR}/../../src/NSString-SQLiteColumnName.m
	${ConsoleTest_SOURCE_DIR}/../../src/NSString-SQLitePersistence.m
	${ConsoleTest_SOURCE_DIR}/../../src/NSString-UppercaseFirst.m
	${ConsoleTest_SOURCE_DIR}/../../src/SQLiteInstanceManager.m
	${ConsoleTest_SOURCE_DIR}/../../src/SQLitePersistentObject.m
)

SET(ConsoleTest_sources
	main.m
	Post.m
	PostCategory.m
)

IF(NOT APPLE)
	ADD_DEFINITIONS(-DTARGET_OS_COCOTRON)
ENDIF(NOT APPLE)

ADD_DEFINITIONS(-std=c99 -DTARGET_OS_MAC)

INCLUDE_DIRECTORIES(../../src)

ADD_EXECUTABLE(ConsoleTest ${SQLitePersistentObject_sources} ${ConsoleTest_sources})

TARGET_LINK_LIBRARIES(ConsoleTest
	${OBJC_LIBS}
	sqlite3
)