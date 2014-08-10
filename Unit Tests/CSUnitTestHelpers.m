//
//  CSUnitTestHelpers.m
//  CSMysteryChallenge
//
//  Created by Tyler Powers on 8/10/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "CSUnitTestHelpers.h"

@implementation CSUnitTestHelpers

+ (id)objectFromFixtureFile:(NSString *)fileName {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *resourcePath = [bundle pathForResource:fileName ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:resourcePath];
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSAssert(object, @"Could not parse fixture: '%@'. Error: %@", fileName, [error localizedDescription]);
    return object;
}

@end
