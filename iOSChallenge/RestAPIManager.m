//
//  RestAPIHandler.m
//  iOSChallenge
//
//  Created by Douglas Barbosa on 24/06/15.
//  Copyright (c) 2015 Douglas Barbosa. All rights reserved.
//

#import "RestAPIManager.h"

#define API_HOME @"https://api.flickr.com/services/rest/"
#define API_KEY @"31550200485e295aaa8b66227ef8a6cf"

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
               
               NSLog(@"JSON: %@", responseDic);
               
               
               if ([[responseDic objectForKey:@"stat"] isEqualToString:@"fail"]) {
                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Image"
                                                                       message:nil
                                                                      delegate:nil
                                                             cancelButtonTitle:@"Ok"
                                                             otherButtonTitles:nil];
                   [alertView show];
                   
                   return;
               }
               
               APIResults *resultsObject = [MTLJSONAdapter modelOfClass:APIResults.class fromJSONDictionary:responseDic error:nil];
               
               [self requestFinishedWithData:resultsObject];
               
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
               
               [self requestFinishedWithData:nil];
           }];
}

- (NSURL *)getPhotoURLWithPhotoObject:(PhotoObject *)photoObject{
    
    NSString *urlString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@_s.jpg", photoObject.farm, photoObject.server, photoObject.photoID, photoObject.secret];
    
    NSURL *imageURL = [NSURL URLWithString:urlString];
    
    NSLog(@"imageURL %@ ", urlString);
    
    return imageURL;

}


- (void)requestFinishedWithData:(APIResults *)results{
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(handleRestResponse:)]) {
        [self.delegate handleRestResponse:results];
    }
}



@end
