//
//  CSDataAccess.m
//  CSMysteryChallenge
//
//  Created by Tyler Powers on 8/10/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "CSDataAccess.h"

@interface CSDataAccess ()

@property (nonatomic, strong) id<CSPersisting>store;
@property (nonatomic, strong) TMAPIClient *apiClient;

@end


@implementation CSDataAccess

objection_register_singleton(CSDataAccess)
objection_requires_sel(@selector(store),
                       @selector(apiClient))

- (void)awakeFromObjection {
    [self buildManagedObjectContexts];
    [self addObserverForContextDidSaveNotification];
    [self setupAPIClient];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    return self.store.persistentStoreCoordinator;
}


#pragma mark - Private

- (void)buildManagedObjectContexts {
    self.persistentStoreMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    self.persistentStoreMOC.persistentStoreCoordinator = [self persistentStoreCoordinator];
    self.persistentStoreMOC.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy;
    
    // Create an MOC for use on the main queue
    self.mainQueueMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.mainQueueMOC.parentContext = self.persistentStoreMOC;
    self.mainQueueMOC.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy;
}

- (void)addObserverForContextDidSaveNotification {
    @weakify(self);
    [[NSNotificationCenter defaultCenter] addObserverForName:NSManagedObjectContextDidSaveNotification
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification *notification) {
                                                      @strongify(self);
                                                      if (notification.object == self.persistentStoreMOC) {
                                                          [self.mainQueueMOC performBlock:^(){
                                                              [self.mainQueueMOC mergeChangesFromContextDidSaveNotification:notification];
                                                          }];
                                                      }
                                                  }];
}

- (void)setupAPIClient {
    self.apiClient.OAuthConsumerKey = @"h9L7plh4MExVm5Df44ZJGjyslX0urpzDhfuksZpp6JhiHujXa6";
    self.apiClient.OAuthConsumerSecret = @"JjlPUaQbMMtyO5tqqvnyHezs1r4rXt0BgprFa0VbMctf1lJEFw";
}

@end
