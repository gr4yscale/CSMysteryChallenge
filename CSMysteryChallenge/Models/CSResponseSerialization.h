//
//  CSResponseSerialization.h
//  CSMysteryChallenge
//
//  Created by Tyler Powers on 8/10/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CSResponseSerialization <NSObject>

- (id)insertObjectForEntityName:(NSString *)entityName fromJSONDictionary:(NSDictionary *)JSONDictionary inManagedObjectContext:(NSManagedObjectContext *)context error:(NSError **)error;

- (NSArray *)insertObjectsForEntityName:(NSString *)entityName fromJSONArray:(NSArray *)JSONArray inManagedObjectContext:(NSManagedObjectContext *)context error:(NSError **)error;

- (id)mergeObjectForEntityName:(NSString *)entityName fromJSONDictionary:(NSDictionary *)JSONDictionary inManagedObjectContext:(NSManagedObjectContext *)context error:(NSError **)error;

- (NSArray *)mergeObjectsForEntityName:(NSString *)entityName fromJSONArray:(NSArray *)JSONArray inManagedObjectContext:(NSManagedObjectContext *)context error:(NSError **)error;

- (NSDictionary *)JSONDictionaryFromManagedObject:(NSManagedObject *)managedObject;

- (NSArray *)JSONArrayFromManagedObjects:(NSArray *)managedObjects;

@end
