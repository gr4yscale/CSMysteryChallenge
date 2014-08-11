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

@interface CSDataAccess : NSObject <CSPersisting>

@property (nonatomic, strong, readonly) TMAPIClient *apiClient;

@property (nonatomic, strong) NSManagedObjectContext *persistentStoreMOC;
@property (nonatomic, strong) NSManagedObjectContext *mainQueueMOC;

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;

@end