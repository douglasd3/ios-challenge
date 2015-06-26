//
//  PhotosResults.h
//  iOSChallenge
//
//  Created by Douglas Barbosa on 24/06/15.
//  Copyright (c) 2015 Douglas Barbosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MTLModel.h>
#import <MTLJSONAdapter.h>
#import "PhotoObject.h"

@interface PhotosResults : MTLModel<MTLJSONSerializing>

@property(nonatomic, retain) NSNumber *page;
@property(nonatomic, retain) NSNumber *pagesNumber;
@property(nonatomic, retain) NSNumber *perpage;
@property(nonatomic, retain) NSArray *photos;
@property(nonatomic, retain) NSNumber *total;

@end
