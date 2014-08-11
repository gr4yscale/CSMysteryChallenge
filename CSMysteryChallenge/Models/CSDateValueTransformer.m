//
//  CSDateValueTransformer.m
//  CSMysteryChallenge
//
//  Created by Tyler Powers on 8/10/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "CSDateValueTransformer.h"

@implementation CSDateValueTransformer

+ (Class)transformedValueClass {
    return [NSDate class];
}

+ (BOOL)allowsReverseTransformation {
    return YES;
}

- (id)transformedValue:(id)value {
    return [NSDate dateWithTimeIntervalSince1970:[value integerValue]];
}

- (id)reverseTransformedValue:(id)value {
    return @([value timeIntervalSince1970]);
}

@end
