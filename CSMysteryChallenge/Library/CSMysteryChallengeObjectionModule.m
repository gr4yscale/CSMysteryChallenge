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
#import "TMAPIClient.h"

@implementation CSMysteryChallengeObjectionModule

- (void)configure {
    [self bind:[TMAPIClient sharedInstance] toClass:[TMAPIClient class]];
    
    [self bindMetaClass:[GRTJSONSerialization class] toProtocol:@protocol(CSResponseSerialization)];
    
    id store = [self configuredStore];
    
    CSDataAccess *dataAccess = [[CSDataAccess alloc] initWithStore:store];
    [dataAccess buildManagedObjectContexts];
    
    [self bind:dataAccess toClass:[CSDataAccess class]];
    
    [self bind:dataAccess.mainQueueMOC toClass:[NSManagedObjectContext class]];
}

- (GRTManagedStore *)configuredStore {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:@[bundle]];
    NSString *path = [[CSPathUtilities documentsDirectory] stringByAppendingPathComponent:@"MysteryChallenge.sqlite"];
    return [[GRTManagedStore alloc] initWithPath:path managedObjectModel:model];
}

@end
