//
//  PhotoInfoOwnerObject.m
//  iOSChallenge
//
//  Created by Instituto Reconcavo on 25/06/15.
//  Copyright (c) 2015 Douglas Barbosa. All rights reserved.
//

#import "PhotoInfoOwner.h"

@implementation PhotoInfoOwner

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"nsid":@"nsid",
             @"username":@"username",
             @"realname":@"realname",
             @"location":@"location",
             @"iconserver":@"iconserver",
             @"iconfarm":@"iconfarm",
             @"path_alias":@"path_alias"
             
             };
}

@end
