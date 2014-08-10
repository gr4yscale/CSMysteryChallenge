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

@implementation CSMysteryChallengeObjectionModule

- (void)configure {
    [self configurePersistenceStore];
}

- (void)configurePersistenceStore {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:@[bundle]];
    NSURL *url = [[NSURL documentsDirectory] URLByAppendingPathComponent:@"MysteryChallenge.sqlite"];
    GRTManagedStore *store = [[GRTManagedStore alloc] initWithPath:[url absoluteString] managedObjectModel:model];
    
    [self bind:store toProtocol:@protocol(CSPersisting)];
}

@end
