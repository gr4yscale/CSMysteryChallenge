//
//  CSResponseDeserializationOperation.m
//  CSMysteryChallenge
//
//  Created by Tyler Powers on 8/10/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "CSResponseDeserializationOperation.h"
#import "CSResponseSerialization.h"

@interface CSResponseDeserializationOperation ()

@property (nonatomic, strong) id objectRepresentation;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSString *entityName;

@property (nonatomic, assign) id<CSResponseSerialization>deserializer;

@end

@implementation CSResponseDeserializationOperation

objection_requires_sel(@selector(deserializer))

- (instancetype)initWithObjectRepresentation:(id)representation entityName:(NSString *)entityName context:(NSManagedObjectContext *)context {
    self = [super init];
    if (self) {
        NSAssert(representation, @"you must provide an object representation.");
        NSAssert(entityName, @"you must specify an entity name.");
        NSAssert(context, @"you must provide a context to deserialize into!");
        
        [[JSObjection defaultInjector] injectDependencies:self];
        
        self.objectRepresentation = representation;
        self.entityName = entityName;
        self.context = context;
    }
    return self;
}

- (void)main {
    NSError *error = nil;
    if ([self.objectRepresentation isKindOfClass:[NSArray class]]) {
        self.deserializedObject = [self.deserializer mergeObjectsForEntityName:self.entityName
                                                                 fromJSONArray:self.objectRepresentation
                                                        inManagedObjectContext:self.context
                                                                         error:&error];
    } else if ([self.objectRepresentation isKindOfClass:[NSDictionary class]]) {
        self.deserializedObject = [self.deserializer mergeObjectForEntityName:self.entityName
                                                           fromJSONDictionary:self.objectRepresentation
                                                       inManagedObjectContext:self.context
                                                                        error:&error];
    }
    self.error = error;
    if (error) {
        NSLog(@"There was an error deserializing object representation: %@", self.objectRepresentation);
        [self.delegate operation:self didFailDeserializingObjectRepresentation:self.objectRepresentation];
    } else {
        [self.delegate operation:self didFinishDeserializingObject:self.deserializedObject];
    }
}

@end
