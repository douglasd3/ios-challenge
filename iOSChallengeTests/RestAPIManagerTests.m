//
//  RestAPIManagerTests.m
//  iOSChallenge
//
//  Created by Instituto Reconcavo on 26/06/15.
//  Copyright (c) 2015 Douglas Barbosa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RestAPIManager.h"

RestAPIManager *apiManager;

@interface RestAPIManagerTests : XCTestCase

@end

@implementation RestAPIManagerTests

- (void)setUp {
    [super setUp];
    apiManager = [[RestAPIManager alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    apiManager = nil;
    [super tearDown];
}

- (void)testGetPhotoURL{
    
    PhotoObject *photo = [[PhotoObject alloc] init];
    
    photo.farm = [NSNumber numberWithInteger:1];
    photo.photoID = [NSNumber numberWithLongLong:18995157138];
    photo.server = [NSNumber numberWithInteger:418];
    photo.secret = @"b87059eb01";
    NSURL *url = [apiManager getPhotoURLWithPhotoObject:photo andSize:@"c"];
    
    XCTAssertNotNil(url);
}

- (void)testGetUserIconURL{
    
    PhotoInfoOwner *owner = [[PhotoInfoOwner alloc] init];
    owner.iconfarm = [NSNumber numberWithInteger:4];
    owner.iconserver = [NSNumber numberWithInteger:3789];
    owner.nsid = @"119402285@N07";
    
    NSURL *url = [apiManager getUserIconURLWithPhotoInfoOwner:owner];
    
    XCTAssertNotNil(url);
    
}

@end
