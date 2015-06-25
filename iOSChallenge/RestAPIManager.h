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
#import "RecentPhotosResults.h"
#import "PhotoInfoResults.h"

@protocol RestAPIManagerDelegate <NSObject>
@optional
- (void) handleRecentPhotosResponse:(RecentPhotosResults *)results;
- (void) handlePhotoInfoResponse:(PhotoInfoResults *)results;
@end

@interface RestAPIManager : NSObject

@property (nonatomic,strong) id <RestAPIManagerDelegate> delegate;

- (void)getRecentPhotosForPage:(NSNumber *)page;
- (void)getPhotoInfoForPhoto:(PhotoObject *)photo;
- (NSURL*)getPhotoURLWithPhotoObject:(PhotoObject *)photoObject;
 

@end
