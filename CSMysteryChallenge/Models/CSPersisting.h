//
//  CSPersisting.h
//  CSMysteryChallenge
//
//  Created by Tyler Powers on 8/10/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CSPersisting <NSObject>

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;

@end
