//
//  CSResponseDeserializationOperation.h
//  CSMysteryChallenge
//
//  Created by Tyler Powers on 8/10/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSResponseDeserializationOperation : NSOperation

@property (nonatomic, strong) id deserializedObject;
@property (nonatomic, strong) NSError *error;

- (instancetype)initWithObjectRepresentation:(id)representation entityName:(NSString *)entityName context:(NSManagedObjectContext *)context;

@end
