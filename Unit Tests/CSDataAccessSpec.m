//
//  CSDataAccessSpec.m
//  CSMysteryChallenge
//
//  Created by Tyler Powers on 8/10/14.
//  Copyright 2014 Couchsurfing. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CSDataAccess.h"

SPEC_BEGIN(CSDataAccessSpec)

describe(@"CSDataAccess", ^{
    __block CSDataAccess *subject;
    
    beforeEach(^{
        subject = [[JSObjection defaultInjector] getObject:[CSDataAccess class]];
    });
   
    it(@"conforms to <CSPersisting> protocol", ^{
        [subject conformsToProtocol:@protocol(CSPersisting)];
    });
    
    it(@"has a persistent store coordinator of kind NSPersistentStoreCoordinator", ^{
        [[subject persistentStoreCoordinator] isKindOfClass:[NSPersistentStoreCoordinator class]];
    });
    
    it(@"has a persistentStoreCoordinator managed object context", ^{
        [[subject.persistentStoreMOC shouldNot] beNil];
    });
    
    it(@"has a mainQueueMOC managed object context", ^{
        [[subject.mainQueueMOC shouldNot] beNil];
    });
    
    it(@"has an API client", ^{
        [[subject.apiClient shouldNot] beNil];
    });
    
});

SPEC_END