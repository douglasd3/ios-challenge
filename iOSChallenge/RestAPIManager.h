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

#define API_HOME @"https://api.flickr.com/services/rest/"
#define API_KEY @"31550200485e295aaa8b66227ef8a6cf"
#define PHOTOS_PER_PAGE @"20"

#define IMAGE_SIZE_THUMB @"s" //75x75
#define IMAGE_SIZE_MEDIUM @"z"
@protocol RestAPIManagerDelegate <NSObject>
@optional
- (void) handleRecentPhotosResponse:(RecentPhotosResults *)results;
- (void) handlePhotoInfoResponse:(PhotoInfoResults *)results;
@end

@interface RestAPIManager : NSObject

@property (nonatomic,strong) id <RestAPIManagerDelegate> delegate;

- (void)getRecentPhotosForPage:(NSNumber *)page;
- (void)getPhotoInfoForPhoto:(PhotoObject *)photo;
- (NSURL *)getPhotoURLWithPhotoObject:(PhotoObject *)photoObject andSize:(NSString *)imgSize;
- (NSURL *)getUserIconURLWithPhotoInfoOwner:(PhotoInfoOwner *)owner;
 

@end
