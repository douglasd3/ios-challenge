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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.apiManager = [[RestAPIManager alloc] init];
    self.apiManager.delegate = self;
    
    currentPage = [NSNumber numberWithInteger:1];
    self.tableContents = [[NSMutableArray alloc] init];
    
    [self.apiManager getRecentPhotosForPage:currentPage];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = [indexPath row];
    currentPhoto = [self.tableContents objectAtIndex:row];
    
    [self performSegueWithIdentifier:@"PhotoInfoSegue" sender:self];
    
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


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
        //NSLog(@"response teste %@", results);
        
        [self setLoadPageViewAction];
        
        currentPage = [NSNumber numberWithInteger:currentPage.integerValue + 1];
        
    }
    
}

@end
