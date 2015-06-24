//
//  PhotoObject.h
//  iOSChallenge
//
//  Created by Douglas Barbosa on 24/06/15.
//  Copyright (c) 2015 Douglas Barbosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MTLModel.h>
#import <MTLJSONAdapter.h>

@interface PhotoObject : MTLModel<MTLJSONSerializing>

@property(nonatomic, retain) NSNumber *farm;
@property(nonatomic, retain) NSNumber *photoID;
@property(nonatomic, retain) NSNumber *isfamily;
@property(nonatomic, retain) NSNumber *isfriend;
@property(nonatomic, retain) NSNumber *ispublic;
@property(nonatomic, retain) NSString *ownerID;
@property(nonatomic, retain) NSString *ownerName;
@property(nonatomic, retain) NSString *secret;
@property(nonatomic, retain) NSNumber *server;
@property(nonatomic, retain) NSString *title;

@end
