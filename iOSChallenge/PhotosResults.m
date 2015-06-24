//
//  PhotosResults.m
//  iOSChallenge
//
//  Created by Douglas Barbosa on 24/06/15.
//  Copyright (c) 2015 Douglas Barbosa. All rights reserved.
//

#import "PhotosResults.h"

@implementation PhotosResults

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // properties defined in header < : > key in JSON Dictionary
    return @{
             @"photos":@"photo",
             @"total":@"total",
             @"page":@"page",
             @"pagesNumber":@"pages",
             @"total":@"total"
             
             };
}

+ (NSValueTransformer *)photosJSONTransformer {
    
    return [MTLJSONAdapter arrayTransformerWithModelClass:PhotoObject.class];
    
}

@end
