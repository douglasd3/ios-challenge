//
//  PhotoInfoTableViewController.m
//  iOSChallenge
//
//  Created by Instituto Reconcavo on 25/06/15.
//  Copyright (c) 2015 Douglas Barbosa. All rights reserved.
//

#import "PhotoInfoTableViewController.h"

NSDictionary *tableContents;
NSArray *keys;
CGFloat imageHeight;
CGFloat descriptionHeight;
UIImage *currentImage;
UIImage *currentUserIcon;

@interface PhotoInfoTableViewController ()

@end

@implementation PhotoInfoTableViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.apiManager = [[RestAPIManager alloc] init];
    self.apiManager.delegate = self;
    currentImage = nil;
    currentUserIcon = nil;
    
    [self.apiManager getPhotoInfoForPhoto:self.photo];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionArray = [tableContents objectForKey:[keys objectAtIndex:section]];
    
    return [sectionArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];

    if (row == 0) {
        return [self userInfoCellAtIndexPath:indexPath];
    }
    else if (row == 1){
        
        return [self imageellAtIndexPath:indexPath];
        
    }
    else if (row == 2){
        return [self descriptionCellAtIndexPath:indexPath];
    }
    else{
        return [self viewCellAtIndexPath:indexPath];
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];

    if (row == 0) {
        return 68;
    }
    else if (row == 1){
        return [self heightForImageCellAtIndexPath:indexPath];
    }
    else if(row == 2){
        return [self heightForDescroptionCellAtIndexPath:indexPath];
    }
    else{
        return 25;
    }
}

#pragma mark - UserCell Config

- (PhotoTableViewCell *)userInfoCellAtIndexPath:(NSIndexPath *)indexPath {
    PhotoTableViewCell *cell = (PhotoTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"UserInfoCell" forIndexPath:indexPath];
    [self configureUserInfoCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureUserInfoCell:(PhotoTableViewCell *)photoCell atIndexPath:(NSIndexPath *)indexPath {
    photoCell.photoOwner.text = self.photo.ownerName;
    photoCell.photoTitle.text = self.photo.title;
    
    photoCell.photoThumb.layer.masksToBounds = YES;
    
    [photoCell.photoThumb setImageWithURL:[self.apiManager getUserIconURLWithPhotoInfoOwner:self.photoInfo.photoOwner] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

#pragma mark - ImageCell Config

- (ImageTableViewCell *)imageellAtIndexPath:(NSIndexPath *)indexPath {
    ImageTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ImageCell" forIndexPath:indexPath];
    [self configureImageCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureImageCell:(ImageTableViewCell *)imageCell atIndexPath:(NSIndexPath *)indexPath {

    if (currentImage == nil) {
        NSURL *url = [self.apiManager getPhotoURLWithPhotoObject:self.photo andSize:IMAGE_SIZE_MEDIUM];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        
        [imageCell.photoImage setImageWithURLRequest:request
                                    placeholderImage:[UIImage imageNamed:@"photoPlaceholder"]
                                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                 currentImage = image;
                                                 
                                                 [self.tableView reloadData];
                                                 
                                                 
                                             } failure:nil];
    }
    else{
        [imageCell.photoImage setBackgroundColor:[UIColor clearColor]];
        [imageCell.photoImage setImage:currentImage];
    }
    

}

- (CGFloat)heightForImageCellAtIndexPath:(NSIndexPath *)indexPath {
    static ImageTableViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:@"ImageCell"];
    });
    
    [self configureImageCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

#pragma mark - DescriptionCell Config

- (UITableViewCell *)descriptionCellAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"DescriptionCell" forIndexPath:indexPath];
    [self configureDescriptionCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureDescriptionCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

    UILabel *descLabel = (UILabel*)[cell.contentView viewWithTag:1];
    
    descLabel.text = self.photoInfo.photoDescription;

}

- (CGFloat)heightForDescroptionCellAtIndexPath:(NSIndexPath *)indexPath {
    static UITableViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:@"DescriptionCell"];
    });
    
    [self configureDescriptionCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

#pragma mark - ViewsCell Config

- (UITableViewCell *)viewCellAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ViewCell" forIndexPath:indexPath];
    [self configureViewCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureViewCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    UILabel *viewLabel = (UILabel*)[cell.contentView viewWithTag:2];
    
    if (!self.photoInfo){
        viewLabel.text = @"";
        
        return;
    }
    viewLabel.text = [NSString stringWithFormat:@"%@ Views - %@ Comments", self.photoInfo.views, self.photoInfo.comments];
    
}

#pragma mark - Auxiliar methods

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.frame), CGRectGetHeight(sizingCell.bounds));
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f; // Add 1.0f for the cell separator height
}

#pragma mark - RestAPIManager Delegate
- (void)handlePhotoInfoResponse:(PhotoInfoResults *)results{
    
    self.photoInfo = results;
    
    NSArray *section1 = @[@"userInfo", @"image", @"description", @"views"];

    //NSArray *section2 = @[@""];

    //tableContents = [NSDictionary dictionaryWithObjectsAndKeys:section1, @"a", section2, @"b", nil];
    
    tableContents = [NSDictionary dictionaryWithObjectsAndKeys:section1, @"a", nil];

    keys = [[tableContents allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    [self.tableView reloadData];
    
}

@end
