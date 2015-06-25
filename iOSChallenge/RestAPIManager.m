//
//  RestAPIHandler.m
//  iOSChallenge
//
//  Created by Douglas Barbosa on 24/06/15.
//  Copyright (c) 2015 Douglas Barbosa. All rights reserved.
//

#import "RestAPIManager.h"


AFHTTPRequestOperationManager *afManager;

@implementation RestAPIManager

- (id)init{
    self = [super init];
    
    if (self) {
        afManager = [AFHTTPRequestOperationManager manager];
        afManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    return self;
}

- (void)getRecentPhotosForPage:(NSNumber *)page{
    
    NSDictionary *parameters = @{@"method": @"flickr.photos.getRecent", @"api_key":API_KEY, @"per_page":PHOTOS_PER_PAGE, @"page":page, @"extras":@"owner_name", @"format":@"json", @"nojsoncallback":@"1"};
    
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
               
               RecentPhotosResults *resultsObject = [MTLJSONAdapter modelOfClass:RecentPhotosResults.class fromJSONDictionary:responseDic error:nil];
               
               [self requestRecentPhotosFinishedWithData:resultsObject];
               
               //NSLog(@"OBJ: %@", resultsObject.photosResults.photos);
           }
     
           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               NSLog(@"Error: %@", error);
               
               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Image"
                                                                   message:[error localizedDescription]
                                                                  delegate:nil
                                                         cancelButtonTitle:@"Ok"
                                                         otherButtonTitles:nil];
               [alertView show];
               
               [self requestRecentPhotosFinishedWithData:nil];
           }];
}

- (void)getPhotoInfoForPhoto:(PhotoObject *)photo{
    
        NSDictionary *parameters = @{@"method": @"flickr.photos.getInfo", @"api_key":API_KEY, @"photo_id":photo.photoID, @"format":@"json", @"nojsoncallback":@"1"};
    
        [afManager GET:API_HOME parameters:parameters
     
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               
               NSDictionary *responseDic = (NSDictionary *)responseObject;
               
               NSLog(@"JSON Antes: %@", responseDic);
               
               
               if ([[responseDic objectForKey:@"stat"] isEqualToString:@"fail"]) {
                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Image"
                                                                       message:nil
                                                                      delegate:nil
                                                             cancelButtonTitle:@"Ok"
                                                             otherButtonTitles:nil];
                   [alertView show];
                   
                   return;
               }
               NSDictionary *photoDic = [responseDic objectForKey:@"photo"];

                NSDictionary *photoInfoDic = [NSDictionary dictionaryWithObjectsAndKeys:[photoDic objectForKey:@"owner"], @"owner", [[photoDic objectForKey:@"description"] objectForKey:@"_content"], @"description", [photoDic objectForKey:@"views"], @"views", [[photoDic objectForKey:@"comments"] objectForKey:@"_content"], @"comments",nil];
               
               NSLog(@"JSON depois: %@", photoInfoDic);
               
               PhotoInfoResults *resultsObject = [MTLJSONAdapter modelOfClass:PhotoInfoResults.class fromJSONDictionary:photoInfoDic error:nil];
               
               [self requestPhotoInfoFinishedWithData:resultsObject];
               
               NSLog(@"OBJ info: %@", resultsObject);
           }
     
           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               NSLog(@"Error: %@", error);
               
               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Image"
                                                                   message:[error localizedDescription]
                                                                  delegate:nil
                                                         cancelButtonTitle:@"Ok"
                                                         otherButtonTitles:nil];
               [alertView show];
               
               [self requestRecentPhotosFinishedWithData:nil];
           }];
    
    
}

- (NSURL *)getPhotoURLWithPhotoObject:(PhotoObject *)photoObject andSize:(NSString *)imgSize{
    
    NSString *urlString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@_%@.jpg", photoObject.farm, photoObject.server, photoObject.photoID, photoObject.secret, imgSize];
    
    NSURL *imageURL = [NSURL URLWithString:urlString];
    
    NSLog(@"imageURL %@ ", urlString);
    
    return imageURL;

}


- (void)requestRecentPhotosFinishedWithData:(RecentPhotosResults *)results{
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(handleRecentPhotosResponse:)]) {
        [self.delegate handleRecentPhotosResponse:results];
    }
}

- (void)requestPhotoInfoFinishedWithData:(PhotoInfoResults *)results{
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(handlePhotoInfoResponse:)]) {
        [self.delegate handlePhotoInfoResponse:results];
    }
}



@end
