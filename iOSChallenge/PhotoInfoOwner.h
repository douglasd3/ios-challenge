//
//  PhotoInfoOwnerObject.h
//  iOSChallenge
//
//  Created by Instituto Reconcavo on 25/06/15.
//  Copyright (c) 2015 Douglas Barbosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MTLModel.h>
#import <MTLJSONAdapter.h>

@interface PhotoInfoOwner : MTLModel<MTLJSONSerializing>

@property(nonatomic, retain) NSString *nsid;
@property(nonatomic, retain) NSString *username;
@property(nonatomic, retain) NSString *realname;
@property(nonatomic, retain) NSString *location;
@property(nonatomic, retain) NSNumber *iconserver;
@property(nonatomic, retain) NSNumber *iconfarm;
@property(nonatomic, retain) NSString *path_alias;


@end
