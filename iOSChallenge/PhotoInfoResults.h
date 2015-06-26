//
//  PhotoInfoObject.h
//  iOSChallenge
//
//  Created by Instituto Reconcavo on 25/06/15.
//  Copyright (c) 2015 Douglas Barbosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MTLModel.h>
#import <MTLJSONAdapter.h>
#import "PhotoInfoOwner.h"

@interface PhotoInfoResults : MTLModel<MTLJSONSerializing>

@property(nonatomic, retain) PhotoInfoOwner *photoOwner;
@property(nonatomic, retain) NSNumber *views;
@property(nonatomic, retain) NSNumber *comments;
@property(nonatomic, retain) NSString *photoDescription;

@end
