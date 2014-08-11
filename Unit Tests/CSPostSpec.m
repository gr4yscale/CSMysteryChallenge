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
        moc = [[JSObjection defaultInjector] getObject:[NSManagedObjectContext class]];
        
        NSDictionary *fixtureDict = [CSUnitTestHelpers objectFromFixtureFile:@"TumblrPostsFixture.json"];
        postsFromFixture = fixtureDict[@"response"][@"posts"];
        
        CSResponseDeserializationOperation *op = [[CSResponseDeserializationOperation alloc] initWithObjectRepresentation:postsFromFixture
                                                                                                               entityName:[CSPost entityName]
                                                                                                                  context:moc];
        [op start];
        post = [op.deserializedObject firstObject];
    });
    
    describe(@"entity mapping", ^{
        it(@"maps identifier", ^{
            [[post.identifier should] equal:@(94094321065)];
        });
        it(@"maps caption", ^{
            [[post.caption should] containString:@"I am in love with the mystery that is traveling"];
        });
        it(@"maps imagePermalink", ^{
            [[post.imagePermalink should] equal:@"http://couchsurfing.tumblr.com/image/94094321065"];
        });
        it(@"maps noteCount", ^{
            [[post.noteCount should] equal:@(13)];
        });
        it(@"maps photos", ^{
            [[[post.photos firstObject][@"original_size"][@"url"] should] equal:@"http://38.media.tumblr.com/87641fcc29ed76423648688b24c2abca/tumblr_n9yfeuezgw1s50vogo1_1280.jpg"];
        });
        it(@"maps postURL", ^{
            [[post.postURL should] equal:@"http://couchsurfing.tumblr.com/post/94094321065/i-am-in-love-with-the-mystery-that-is-traveling"];
        });
        it(@"maps shortURL", ^{
            [[post.shortURL should] equal:@"http://tmblr.co/Zp5F6t1NeTMMf"];
        });
        it(@"maps tags", ^{
            [[post.tags should] contain:@"couchsurfing"];
            [[post.tags should] contain:@"road trip"];
            [[post.tags should] contain:@"adventures"];
            [[post.tags should] contain:@"travel"];
            [[post.tags should] contain:@"Travel Photography"];
            [[post.tags should] contain:@"roadtrip"];
            [[post.tags should] contain:@"western united states"];
        });
        it(@"maps timestamp", ^{
            [[post.timestamp should] equal:[NSDate dateWithTimeIntervalSince1970:1407444870]];
        });
    });
  
});

SPEC_END