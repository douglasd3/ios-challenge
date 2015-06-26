//
//  PhotosListTableViewController.m
//  iOSChallenge
//
//  Created by Douglas Barbosa on 24/06/15.
//  Copyright (c) 2015 Douglas Barbosa. All rights reserved.
//

#import "PhotosListTableViewController.h"

NSNumber *currentPage;
PhotoObject *currentPhoto;

@interface PhotosListTableViewController ()

@end

@implementation PhotosListTableViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.apiManager = [[RestAPIManager alloc] init];
    self.apiManager.delegate = self;
    
    currentPage = [NSNumber numberWithInteger:1];
    self.tableContents = [[NSMutableArray alloc] init];
    
    [self.apiManager getRecentPhotosForPage:currentPage];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - auxiliar methods

- (void)setLoadPageViewAction{
    
    [self.loadPageView setHidden:NO];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLoadPageAction:)];
    
    [self.loadPageView addGestureRecognizer:tap];
    
}

- (void)tapLoadPageAction:(UITapGestureRecognizer *)tapGestureRecognizer{
    
    [self.apiManager getRecentPhotosForPage:currentPage];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.tableContents count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = [indexPath row];
    
    PhotoTableViewCell *cell = (PhotoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    PhotoObject *photo = [self.tableContents objectAtIndex:row];
    
    cell.photoTitle.text = photo.title;
    cell.photoOwner.text = photo.ownerName;
    
    cell.photoThumb.layer.masksToBounds = YES;
    
    [cell.photoThumb setImageWithURL:[self.apiManager getPhotoURLWithPhotoObject:photo andSize:IMAGE_SIZE_THUMB]placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = [indexPath row];
    currentPhoto = [self.tableContents objectAtIndex:row];
    
    [self performSegueWithIdentifier:@"PhotoInfoSegue" sender:self];
    
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    PhotoInfoTableViewController *photoInfoView = (PhotoInfoTableViewController *)[segue destinationViewController];
    
    photoInfoView.photo = currentPhoto;
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


#pragma mark - RestAPIManager delegate

- (void)handleRecentPhotosResponse:(RecentPhotosResults *)results{
    
    if (results) {
        
        [self.tableContents addObjectsFromArray:results.photosResults.photos];
        
        //self.tableContents = [NSMutableArray arrayWithArray:results.photosResults.photos];
        
        [self.tableView reloadData];
        
        [self setLoadPageViewAction];
        
        currentPage = [NSNumber numberWithInteger:currentPage.integerValue + 1];
        
    }
    
}

@end
