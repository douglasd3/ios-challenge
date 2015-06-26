//
//  APIResults.h
//  iOSChallenge
//
//  Created by Douglas Barbosa on 24/06/15.
//  Copyright (c) 2015 Douglas Barbosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MTLModel.h>
#import <MTLJSONAdapter.h>
#import "PhotosResults.h"

@interface RecentPhotosResults : MTLModel<MTLJSONSerializing>

@property(nonatomic, retain) PhotosResults *photosResults;
@property(nonatomic, retain) NSString *status;

@end
