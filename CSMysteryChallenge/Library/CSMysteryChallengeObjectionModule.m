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
#import "CSPathUtilities.h"
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
    NSString *path = [[CSPathUtilities documentsDirectory] stringByAppendingPathComponent:@"MysteryChallenge.sqlite"];
    return (id<CSPersisting>)[[GRTManagedStore alloc] initWithPath:path managedObjectModel:model];
}

@end
