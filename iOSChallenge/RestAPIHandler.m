//
//  RestAPIHandler.m
//  iOSChallenge
//
//  Created by Douglas Barbosa on 24/06/15.
//  Copyright (c) 2015 Douglas Barbosa. All rights reserved.
//

#import "RestAPIHandler.h"

#define API_HOME @"https://api.flickr.com/services/rest/"
#define API_KEY @"5f1bda0ff51d35493f69a98774a10279"

AFHTTPRequestOperationManager *afManager;

@implementation RestAPIHandler

- (id)init{
    self = [super init];
    
    if (self) {
        afManager = [AFHTTPRequestOperationManager manager];
    }
    
    return self;
}

- (void)getRecentPhotos{
    
    NSDictionary *parameters = @{@"method": @"flickr.photos.getRecent", @"api_key":API_KEY, @"extras":@"owner_name", @"format":@"json", @"nojsoncallback":@"1"};
    
    [afManager GET:API_HOME parameters:parameters
     
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               NSLog(@"JSON: %@", responseObject);}
     
           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               NSLog(@"Error: %@", error);
               
               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Image"
                                                                   message:[error localizedDescription]
                                                                  delegate:nil
                                                         cancelButtonTitle:@"Ok"
                                                         otherButtonTitles:nil];
               [alertView show];
           }];
}



@end
