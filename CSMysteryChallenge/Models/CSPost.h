//
//  CSPost.h
//  CSMysteryChallenge
//
//  Created by Tyler Powers on 8/10/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CSPost : NSManagedObject

@property (nonatomic, retain) NSString * caption;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * imagePermalink;
@property (nonatomic, retain) NSNumber * noteCount;
@property (nonatomic, retain) id photos;
@property (nonatomic, retain) NSString * postURL;
@property (nonatomic, retain) NSString * shortURL;
@property (nonatomic, retain) id tags;
@property (nonatomic, retain) NSDate * timestamp;

+ (NSString *)entityName;

@end
