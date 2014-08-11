//
//  CSPost.m
//  CSMysteryChallenge
//
//  Created by Tyler Powers on 8/10/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "CSPost.h"


@implementation CSPost

@dynamic caption;
@dynamic identifier;
@dynamic imagePermalink;
@dynamic noteCount;
@dynamic photos;
@dynamic postURL;
@dynamic shortURL;
@dynamic tags;
@dynamic timestamp;

+ (NSString *)entityName {
    return @"CSPost";
}

@end
