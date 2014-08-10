//
//  NSURL+CSAdditions.m
//  CSMysteryChallenge
//
//  Created by Tyler Powers on 8/10/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "NSURL+CSAdditions.h"

@implementation NSURL (CSAdditions)

+ (NSURL *)documentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
