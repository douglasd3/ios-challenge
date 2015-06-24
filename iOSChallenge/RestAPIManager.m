//
//  RestAPIHandler.m
//  iOSChallenge
//
//  Created by Douglas Barbosa on 24/06/15.
//  Copyright (c) 2015 Douglas Barbosa. All rights reserved.
//

#import "RestAPIManager.h"

#define API_HOME @"https://api.flickr.com/services/rest/"
#define API_KEY @"5f1bda0ff51d35493f69a98774a10279"

AFHTTPRequestOperationManager *afManager;

@implementation RestAPIManager

- (id)init{
    self = [super init];
    
    if (self) {
        afManager = [AFHTTPRequestOperationManager manager];
    }
    
    return self;
}

- (void)getRecentPhotos{
    
    NSDictionary *parameters = @{@"method": @"flickr.photos.getRecent", @"api_key":API_KEY, @"extras":@"owner_name", @"format":@"json", @"nojsoncallback":@"1"};
    
    afManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [afManager GET:API_HOME parameters:parameters
     
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               
               NSDictionary *responseDic = (NSDictionary *)responseObject;
               
               APIResults *resultsObject = [MTLJSONAdapter modelOfClass:APIResults.class fromJSONDictionary:responseDic error:nil];
               
               NSLog(@"JSON: %@", responseDic);
               NSLog(@"OBJ: %@", resultsObject.photosResults.photos);
           }
     
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
