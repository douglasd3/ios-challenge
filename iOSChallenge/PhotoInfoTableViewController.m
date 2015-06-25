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
UIImage *currentImage;
UIImage *currentUserIcon;

@interface PhotoInfoTableViewController ()

@end

@implementation PhotoInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Photow %@ ", self.photo);
    
    self.apiManager = [[RestAPIManager alloc] init];
    self.apiManager.delegate = self;
    imageHeight = 0;
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
    
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    NSString *cellIdentifier = @"Cell";
    
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (section == 0) {
        if (row == 0) {
            cellIdentifier = @"UserInfoCell";
        }
        else if (row == 1){
            cellIdentifier = @"ImageCell";
        }
    
    }
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    
    
    if (section == 0) {
        if (row == 0) {
            
            PhotoTableViewCell *photoCell = (PhotoTableViewCell *) cell;
            photoCell.photoOwner.text = self.photo.ownerName;
            photoCell.photoTitle.text = self.photo.title;
            
            photoCell.photoThumb.layer.masksToBounds = YES;
            
            [photoCell.photoThumb setImageWithURL:[self.apiManager getUserIconURLWithPhotoInfoOwner:self.photoInfo.photoOwner] placeholderImage:[UIImage imageNamed:@"placeholder"]];

        }
        else if(row == 1){
            
            ImageTableViewCell *imageCell = (ImageTableViewCell *)cell;
            
            NSURL *url = [self.apiManager getPhotoURLWithPhotoObject:self.photo andSize:IMAGE_SIZE_MEDIUM];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
            if (currentImage == nil) {
                [imageCell.photoImage setImageWithURLRequest:request
                                            placeholderImage:[UIImage imageNamed:@"placeholder"]
                                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                         NSLog(@"height i %f", image.size.height);
                                                         NSLog(@"width i %f", image.size.width);
                                                        
                                                         imageHeight = image.size.height;
                                                         
                                                         currentImage = image;
                                                         
                                                         [self.tableView reloadData];
                                                         
                                                     } failure:nil];

            }
            else{
                [imageCell.photoImage setImage:currentImage];
                
            }
            
        }
    }
    
    return cell;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    if (section == 0) {
        if (row == 0) {
            return 64;
        }
        else if (row == 1){
            return imageHeight;
        }
    }
    
    return 44;
    
    
}

- (void)handlePhotoInfoResponse:(PhotoInfoResults *)results{
    
    self.photoInfo = results;
    
    NSArray *section1 = @[@"userInfo", @"image", @"description"];

    NSArray *section2 = @[@""];

    tableContents = [NSDictionary dictionaryWithObjectsAndKeys:section1, @"a", section2, @"b", nil];

    keys = [[tableContents allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    [self.tableView reloadData];
    
}

@end
