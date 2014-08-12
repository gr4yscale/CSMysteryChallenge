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
@dynamic body;
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

- (NSURL *)firstImageURL {
    NSString *urlString = [self.photos firstObject][@"original_size"][@"url"];
    return [NSURL URLWithString:urlString];
}

- (CGSize)sizeForFirstImage {
    NSDictionary *sizeDict = [self.photos firstObject][@"original_size"];
    return CGSizeMake([sizeDict[@"width"] floatValue], [sizeDict[@"height"] floatValue]);
}

@end
