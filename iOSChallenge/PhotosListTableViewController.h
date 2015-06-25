//
//  PhotosListTableViewController.h
//  iOSChallenge
//
//  Created by Douglas Barbosa on 24/06/15.
//  Copyright (c) 2015 Douglas Barbosa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestAPIManager.h"
#import "PhotoTableViewCell.h"

@interface PhotosListTableViewController : UITableViewController<RestAPIManagerDelegate>

@property(nonatomic, retain) NSMutableArray *tableContents;
@property(nonatomic, retain) RestAPIManager *apiManager;

@end
