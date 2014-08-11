//
//  CSMysteryChallengeObjectionModule.m
//  CSMysteryChallenge
//
//  Created by Tyler Powers on 8/10/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "CSMysteryChallengeObjectionModule.h"
#import <Objection.h>
#import <Groot/Groot.h>
#import "NSURL+CSAdditions.h"
#import "CSPersisting.h"
#import "CSDataAccess.h"
#import "CSResponseSerialization.h"

@implementation CSMysteryChallengeObjectionModule

- (void)configure {
    [self bindMetaClass:[GRTJSONSerialization class] toProtocol:@protocol(CSResponseSerialization)];
    
    CSDataAccess *dataAccess = [[CSDataAccess alloc] initWithStore:[self configuredPersistenceStore]];
    [self bind:dataAccess toClass:[CSDataAccess class]];
}

- (id<CSPersisting>)configuredPersistenceStore {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:@[bundle]];
    NSURL *url = [[NSURL documentsDirectory] URLByAppendingPathComponent:@"MysteryChallenge.sqlite"];
    return (id<CSPersisting>)[[GRTManagedStore alloc] initWithPath:[url absoluteString] managedObjectModel:model];
}

@end
