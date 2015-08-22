//
//  DatabaseManager.h
//  FameLive
//
//  Created by Intelligrape on 6/26/15.
//  Copyright (c) 2015 intelligrape. All rights reserved.
//

#define MANAGED_OBJECT_CONTEXT [NSManagedObjectContext MR_contextForCurrentThread]

#import <Foundation/Foundation.h>

@interface DatabaseManager : NSObject

+ (DatabaseManager *)sharedDatabaseManager;


-(NSArray *)getArrayOfProperty:(NSString *)propertyName inEntity:(NSString *)entityName withCondition:(NSPredicate *)condition;
-(NSArray *)findAllInEntity:(NSString *)entityName withCondition:(NSPredicate *)condition;
-(NSArray *)findEntity:(NSString *)entityName withCondition:(NSPredicate *)condition;


//Own Method

#pragma mark-
#pragma mark- Insert
-(void)saveGenreDataFromGenreArray:(NSArray *)array;
- (void)insertWatchSecondsData:(NSDictionary  *)dictionary;
-(void)insertFailedDataIntoDatabase:(NSDictionary *)dict;


#pragma mark- Get
-(NSArray *)getWatchSecondsData;
-(NSArray *)getGenresData;

#pragma mark- Remove
-(void )removeWatchSecondsData:(NSDate *)timeStamp;

#pragma mark- Remove

- (BOOL)removeSavedGenre;

@end
