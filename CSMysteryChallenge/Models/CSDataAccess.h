//
//  CSDataAccess.h
//  CSMysteryChallenge
//
//  Created by Tyler Powers on 8/10/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSPersisting.h"
#import "TMAPIClient.h"
#import "CSResponseDeserializationOperation.h"

typedef void (^CSFetchCompletionHandler)(id response, NSError *error);

@interface CSDataAccess : NSObject <CSPersisting, CSResponseDeserializationOperationDelegate>

@property (nonatomic, strong, readonly) TMAPIClient *apiClient;

@property (nonatomic, strong) NSManagedObjectContext *persistentStoreMOC;
@property (nonatomic, strong) NSManagedObjectContext *mainQueueMOC;

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (void)fetchPostsAtOffset:(NSUInteger)offset pageSize:(NSUInteger)pageSize completion:(CSFetchCompletionHandler)completion;

@end