//
//  CSDataAccess.m
//  CSMysteryChallenge
//
//  Created by Tyler Powers on 8/10/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "CSDataAccess.h"
#import "CSPersisting.h"

@interface CSDataAccess ()

@property (nonatomic, strong) id<CSPersisting> store;
@property (nonatomic, strong) NSManagedObjectContext *persistentStoreMOC;
@property (nonatomic, strong) NSManagedObjectContext *mainQueueMOC;

@end


@implementation CSDataAccess

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self buildManagedObjectContexts];
    }
    return self;
}


#pragma mark - Private

- (void)buildManagedObjectContexts {
    self.persistentStoreMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    self.persistentStoreMOC.persistentStoreCoordinator = self.store.persistentStoreCoordinator;
    self.persistentStoreMOC.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy;
    
    // Create an MOC for use on the main queue
    self.mainQueueMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.mainQueueMOC.parentContext = self.persistentStoreMOC;
    self.mainQueueMOC.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy;
}

@end
