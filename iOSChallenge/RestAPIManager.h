//
//  RestAPIHandler.h
//  iOSChallenge
//
//  Created by Douglas Barbosa on 24/06/15.
//  Copyright (c) 2015 Douglas Barbosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>
#import "APIResults.h"

@protocol RestAPIManagerDelegate <NSObject>
@required
- (void) handleRestResponse:(APIResults *)results;
@end

@interface RestAPIManager : NSObject

@property (nonatomic,strong) id <RestAPIManagerDelegate> delegate;

- (void)getRecentPhotosForPage:(NSNumber *)page;
- (NSURL*)getPhotoURLWithPhotoObject:(PhotoObject *)photoObject;
 

@end
