//
//  PhotoObject.m
//  iOSChallenge
//
//  Created by Douglas Barbosa on 24/06/15.
//  Copyright (c) 2015 Douglas Barbosa. All rights reserved.
//

#import "PhotoObject.h"

@implementation PhotoObject

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // properties defined in header < : > key in JSON Dictionary
    return @{
             @"photoID":@"id",
             @"ownerID":@"owner",
             @"ownerName":@"ownername",
             @"farm":@"farm",
             @"isfamily":@"isfamily",
             @"isfriend":@"isfriend",
             @"ispublic":@"ispublic",
             @"secret":@"secret",
             @"server":@"server",
             @"title":@"title"
             };
}


@end
