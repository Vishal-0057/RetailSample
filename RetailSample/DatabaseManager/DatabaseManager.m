//
//  DatabaseManager.m
//  FameLive
//
//  Created by Intelligrape on 6/26/15.
//  Copyright (c) 2015 intelligrape. All rights reserved.
//


#import "DatabaseManager.h"
#import "CoreDataModals.h"
#import "NSObject+PE.h"

#define CONTINUE_IF_MAIN_THREAD if ([NSThread isMainThread] == NO) { NSAssert(FALSE, @"Not called from main thread"); }
#define TIME_DELAY_IN_FREQUENTLY_SAVING_CHANGES 1

@implementation DatabaseManager

#define MANAGED_OBJECT_CONTEXT [NSManagedObjectContext MR_contextForCurrentThread]


#pragma mark - initializer methods

static DatabaseManager * databaseManager_ = nil;

+ (DatabaseManager *)sharedDatabaseManager {
    CONTINUE_IF_MAIN_THREAD @synchronized(databaseManager_) {
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            if (databaseManager_ == nil) {
                databaseManager_ = [[DatabaseManager alloc]init];
                [MagicalRecord setupCoreDataStack];
//                [MagicalRecord setupAutoMigratingCoreDataStack];
            }
        });
    }
    
    return databaseManager_;
}

+ (id)alloc {
    NSAssert(databaseManager_ == nil, @"Attempted to allocate a second instance of a singleton.");
    return [super alloc];
}

#pragma mark- Own Method


-(void)insertFailedDataIntoDatabase:(NSDictionary *)dict
{
//    if([dict[kType] isEqualToString:kWatchSeconds])
//    {
//        [self insertWatchSecondsData:dict];
//    }
}


- (void)insertWatchSecondsData:(NSDictionary  *)dictionary  {
    
//  WatchSeconds *obj = [WatchSeconds MR_createInContext:MANAGED_OBJECT_CONTEXT];
//    
//    obj.contentId   = [Utility safeInsertInField:obj.contentId fromDataSource:[dictionary objectForKey:@"contentId"]];
//    
//    obj.contentType = [Utility safeInsertInField:obj.contentType fromDataSource:[dictionary objectForKey:@"contentType"]];
//    obj.startTimeStamp = [Utility safeInsertInField:obj.startTimeStamp fromDataSource:[dictionary objectForKey:@"startTime"]];
//    obj.endTimeStamp = [Utility safeInsertInField:obj.endTimeStamp fromDataSource:[dictionary objectForKey:@"endTime"]];
//    obj.timeStamp = [Utility safeInsertInField:obj.timeStamp fromDataSource:[self getFormatedTimeStamp:[dictionary objectForKey:@"timestamp"]]];
//    obj.deviceId = [Utility safeInsertInField:obj.deviceId fromDataSource:[dictionary objectForKey:@"deviceId"]];
//    obj.platform = [Utility safeInsertInField:obj.platform fromDataSource:[dictionary objectForKey:@"platform"]];
//    obj.userId = [Utility safeInsertInField:obj.userId fromDataSource:[dictionary objectForKey:@"userId"]];
//    obj.watchDuration = [Utility safeInsertInField:obj.watchDuration fromDataSource:[dictionary objectForKey:@"watchDuration"]];
//    obj.ip = [Utility safeInsertInField:obj.ip fromDataSource:[dictionary objectForKey:@"ip"]];
//    obj.numberOfReconnect = [Utility safeInsertInField:obj.numberOfReconnect fromDataSource:[dictionary objectForKey:@"numberOfReconnects"]];
    
    [self saveData];
}

-(NSDate *)getFormatedTimeStamp:(NSString *)dateString{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormat setTimeZone:gmt];
    NSLog(@"%@",[dateFormat dateFromString:dateString]);
    return [dateFormat dateFromString:dateString];
}


-(NSArray *)getWatchSecondsData
{
    return nil;//[WatchSeconds MR_findAllSortedBy:@"timeStamp" ascending:YES inContext:MANAGED_OBJECT_CONTEXT];
}

-(NSArray *)getGenresData
{
    return nil;//[Genres MR_findAll];
}

-(void)saveGenreDataFromGenreArray:(NSArray *)array
{
//    for (NSDictionary *dictionary in array) {
//        Genres * genreObj = [Genres MR_createInContext:MANAGED_OBJECT_CONTEXT];
//        
//        genreObj.genreId =[Utility safeInsertInField:genreObj.genreId fromDataSource:[dictionary objectForKey:@"id"]];
//        
//        genreObj.genreName =[Utility safeInsertInField:genreObj.genreName fromDataSource:[dictionary objectForKey:@"name"]];
//        
//        genreObj.genreImageName =[Utility safeInsertInField:genreObj.genreImageName fromDataSource:[dictionary objectForKey:@"imageName"]];
//        
//        if([self isNotNull:[dictionary objectForKey:@"subTags"]])
//        {
//            for (NSDictionary *dict in [dictionary objectForKey:@"subTags"]) {
//                SubGenre * subGenreObj = [SubGenre MR_createInContext:MANAGED_OBJECT_CONTEXT];
//                subGenreObj.subGenreName=[Utility safeInsertInField:subGenreObj.subGenreName fromDataSource:[dict objectForKey:@"name"]];
//                [genreObj addSubGenresObject:subGenreObj];
//            }
//        }
//        [self saveData];
//    }
    
}


- (BOOL )removeSavedGenre {
    
//  BOOL success= [Genres MR_truncateAllInContext:MANAGED_OBJECT_CONTEXT];
//    [self saveData];
    
    return FALSE;//success;
}

-(void )removeWatchSecondsData:(NSDate *)timeStamp
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"timeStamp <= %@", timeStamp];
    //[WatchSeconds MR_deleteAllMatchingPredicate:predicate inContext:MANAGED_OBJECT_CONTEXT];
     [self saveData];
}

-(void)updateInsertedEnityName:(NSString *)entityName
{
//    InsertedEntityRecord *insertedObj=nil;
//    insertedObj=[InsertedEntityRecord MR_findFirstByAttribute:@"insertedEntityName" withValue:entityName];
//    
//    if (!insertedObj) {
//        insertedObj = [InsertedEntityRecord MR_createInContext:MANAGED_OBJECT_CONTEXT];
//    }
//    
//    insertedObj.insertedEntityName = entityName;
//    insertedObj.isRecordInserted=[NSNumber numberWithBool:YES];
    
    [self saveData];
}

// array of a single property by condition
-(NSArray *)getArrayOfProperty:(NSString *)propertyName inEntity:(NSString *)entityName withCondition:(NSPredicate *)condition
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:MANAGED_OBJECT_CONTEXT];
    [fetchRequest setEntity:entity];
    fetchRequest.propertiesToFetch = [NSArray arrayWithObject:[[entity propertiesByName] objectForKey:propertyName]];
    fetchRequest.returnsDistinctResults = YES;
    fetchRequest.resultType = NSDictionaryResultType;
    [fetchRequest setPredicate:condition];
    NSError *error;
    return [MANAGED_OBJECT_CONTEXT executeFetchRequest:fetchRequest error:&error];
}

-(NSArray *)findAllInEntity:(NSString *)entityName withCondition:(NSPredicate *)condition
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:MANAGED_OBJECT_CONTEXT];
    [fetchRequest setEntity:entity];
    //fetchRequest.resultType = NSDictionaryResultType;
    [fetchRequest setPredicate:condition];
    NSError *error;
    return [MANAGED_OBJECT_CONTEXT executeFetchRequest:fetchRequest error:&error];
}


-(NSArray *)findEntity:(NSString *)entityName withCondition:(NSPredicate *)condition
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:MANAGED_OBJECT_CONTEXT];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:condition];
    NSError *error;
    return [MANAGED_OBJECT_CONTEXT executeFetchRequest:fetchRequest error:&error];
}

#pragma mark - common methods to work with core data

- (void)saveData {
    static NSTimer *timer = nil;
    if ([self isNotNull:timer])
        [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:TIME_DELAY_IN_FREQUENTLY_SAVING_CHANGES target:self selector:@selector(actuallySave) userInfo:nil repeats:NO];
}

- (void)actuallySave {
    [MANAGED_OBJECT_CONTEXT MR_saveToPersistentStoreAndWait];
}

- (void)resetCompleteDatabase {
    //[UserInfo MR_truncateAllInContext:MANAGED_OBJECT_CONTEXT];
    [self saveData];
}

- (NSMutableArray *)getAllContentsFor:(Class)entity {
    return [self getAllContentsUsingContext:MANAGED_OBJECT_CONTEXT ForEntity:entity WithPredicate:nil asDictionary:NO];
}

- (NSMutableArray *)getAllContentsUsingContext:(NSManagedObjectContext *)context ForEntity:(Class)entity WithPredicate:(NSPredicate *)predicate asDictionary:(BOOL)asDictionary {
    NSArray *results = [entity MR_findAllWithPredicate:predicate];
    return [[NSMutableArray alloc]initWithArray:results];
}

- (id)fetchSingleForEntity:(Class)entity WithPredicate:(NSPredicate *)predicate {
    return [entity MR_findFirstWithPredicate:predicate];
}



@end
