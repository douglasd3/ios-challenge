//
//  PhotoInfoTableViewController.h
//  iOSChallenge
//
//  Created by Instituto Reconcavo on 25/06/15.
//  Copyright (c) 2015 Douglas Barbosa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestAPIManager.h"
#import "PhotoObject.h"
#import "PhotoInfoResults.h"

@interface PhotoInfoTableViewController : UITableViewController

@property(nonatomic, retain) PhotoObject *photo;
@property(nonatomic, retain) PhotoInfoResults *photoInfo;

@end
