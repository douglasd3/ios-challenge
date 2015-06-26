//
//  APIResults.m
//  iOSChallenge
//
//  Created by Douglas Barbosa on 24/06/15.
//  Copyright (c) 2015 Douglas Barbosa. All rights reserved.
//

#import "RecentPhotosResults.h"

@implementation RecentPhotosResults

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"photosResults":@"photos",
             @"status":@"stat",
             };
}


+ (NSValueTransformer *)photosResultsJSONTransformer {
    
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:PhotosResults.class];

}

@end
