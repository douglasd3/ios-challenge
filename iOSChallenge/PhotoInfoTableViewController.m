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

@interface PhotoInfoTableViewController ()

@end

@implementation PhotoInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Photo %@ ", self.photo);
    
    self.apiManager = [[RestAPIManager alloc] init];
    self.apiManager.delegate = self;
    
    [self.apiManager getPhotoInfoForPhoto:self.photo];
    
//    NSArray *section1 = @[@"userInfo", @"image", @"description"];
//    
//    NSArray *section2 = @[@""];
//    
//    menuItems = [NSDictionary dictionaryWithObjectsAndKeys:temp1, @"a", temp2, @"b", nil];
//    
//    keys = [[menuItems allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    //[teste getPhotoInfoForPhoto:self.photo];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    
    if (section == 0) {
        if (row == 0) {
            cellIdentifier = @"UserInfoCell";
        }
    }
    
    PhotoTableViewCell *cell = (PhotoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    if (section == 0) {
        if (row == 0) {
            cell.photoOwner.text = self.photo.ownerName;
            cell.photoTitle.text = self.photo.title;
            
            cell.photoThumb.layer.masksToBounds = YES;
            
            [cell.photoThumb setImageWithURL:[self.apiManager getUserIconURLWithPhotoInfoOwner:self.photoInfo.photoOwner] placeholderImage:[UIImage imageNamed:@"placeholder"]];

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
