//
//  PhotoInfoObject.m
//  iOSChallenge
//
//  Created by Instituto Reconcavo on 25/06/15.
//  Copyright (c) 2015 Douglas Barbosa. All rights reserved.
//

#import "PhotoInfoResults.h"

@implementation PhotoInfoResults

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // properties defined in header < : > key in JSON Dictionary
    return @{
             @"photoOwner":@"owner",
             @"views":@"views",
             @"comments":@"comments",
             @"photoDescription":@"description"
             
             };
}

+ (NSValueTransformer *)photoOwnerJSONTransformer {
    
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:PhotoInfoOwner.class];
    
}

@end
