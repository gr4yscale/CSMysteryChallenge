//
//  CSResponseDeserializationOperation.h
//  CSMysteryChallenge
//
//  Created by Tyler Powers on 8/10/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CSResponseDeserializationOperationDelegate;

@interface CSResponseDeserializationOperation : NSOperation

@property (nonatomic, strong) id deserializedObject;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, weak) id<CSResponseDeserializationOperationDelegate>delegate;

- (instancetype)initWithObjectRepresentation:(id)representation entityName:(NSString *)entityName context:(NSManagedObjectContext *)context;

@end


@protocol CSResponseDeserializationOperationDelegate <NSObject>

- (void)operation:(CSResponseDeserializationOperation *)operation didFinishDeserializingObject:(id)deserializedObject;
- (void)operation:(CSResponseDeserializationOperation *)operation didFailDeserializingObjectRepresentation:(id)representation;

@end
