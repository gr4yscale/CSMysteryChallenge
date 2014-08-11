//
//  CSPostSpec.m
//  CSMysteryChallenge
//
//  Created by Tyler Powers on 8/10/14.
//  Copyright 2014 Couchsurfing. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "CSPost.h"
#import "CSUnitTestHelpers.h"
#import "CSDataAccess.h"
#import "CSUnitTestHelpers.h"
#import "CSResponseDeserializationOperation.h"

SPEC_BEGIN(CSPostSpec)

describe(@"CSPost", ^{
    __block CSDataAccess *dataAccess;
    __block NSManagedObjectContext *moc;
    __block NSArray *postsFromFixture;
    __block CSPost *post;
    
    beforeEach(^{
        dataAccess = [[JSObjection defaultInjector] getObject:[CSDataAccess class]];
        moc = dataAccess.persistentStoreMOC;
        
        NSDictionary *fixtureDict = [CSUnitTestHelpers objectFromFixtureFile:@"TumblrPostsFixture.json"];
        postsFromFixture = fixtureDict[@"response"][@"posts"];
        
        CSResponseDeserializationOperation *op = [[CSResponseDeserializationOperation alloc] initWithObjectRepresentation:postsFromFixture
                                                                                                               entityName:[CSPost entityName]
                                                                                                                  context:moc];
        [op start];
        post = [op.deserializedObject firstObject];
    });
    
    describe(@"entity mapping", ^{
        it(@"mapps identifier", ^{
            [[post.identifier should] equal:@(94094321065)];
        });
    });
  
});

SPEC_END