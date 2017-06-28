//
//  SearchViewController.m
//  MyIslandProperty
//
//  Created by Adrian Rusin on 12/24/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "SearchViewController.h"
#import "DetailCollectionViewController.h"
#import "MBProgressHUD.h"
#import "DropboxCell.h"
#import "DetailCollectionViewController.h"

@interface SearchViewController ()<UISearchBarDelegate>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!loadData) {
        loadData = @"";
    }
    
    marrDownloadData = [[NSMutableArray alloc] init];
    searchedResult = [[NSMutableArray alloc]init];
    imageArray = [[NSMutableArray alloc]init];
    countArray = [[NSMutableArray alloc]init];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self performSelector:@selector(fetchAllDropboxData) withObject:nil afterDelay:.1];
//    strArray = [[NSMutableArray alloc]init];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    
}

#pragma mark - Dropbox Methods
- (DBRestClient *)restClient
{
    if (restClient == nil) {
        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        restClient.delegate = self;
    }
    return restClient;
}

-(void)fetchAllDropboxData
{
    [self.restClient loadMetadata:@""];
}

-(void)downloadFileFromDropBox:(NSString *)filePath
{
    [self.restClient loadFile:filePath intoPath:[[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[filePath lastPathComponent]]];
}

#pragma mark - DBRestClientDelegate Methods for Load Data
- (void)restClient:(DBRestClient*)client loadedMetadata:(DBMetadata *)metadata
{
//    int  j=0; //for indexing filename
    for (int i = 0; i < [metadata.contents count]; i++) {
//        j++;
//        NSString *localDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//       
        DBMetadata *data = [metadata.contents objectAtIndex:i];
//        NSString *filename = [NSString stringWithFormat:@"file%d.jpg", j];
//        NSString *localPath = [localDir stringByAppendingPathComponent:filename];
        
        if (data.isDirectory) {
            
            
            [marrDownloadData addObject:data];
            [searchedResult addObject:data];
            [countArray addObject:[NSNumber numberWithInteger:[data.contents count]]];
            
            NSLog(@"directory name : %@", data.filename);
            NSLog(@"directory path : %@", data.path);
            NSLog(@"directory count : %@", data.contents);
            
            if ([data.contents count] != 0) {
//                for (DBMetadata *file in metadata.contents) {
//                    NSLog(@"count=%lu	%@", data.contents.count, file.filename);
//                }
                DBMetadata *fileData = [data.contents objectAtIndex:1];
                NSLog(@"first file : %@", fileData.filename);
//                [self.restClient loadFile:fileData.path intoPath:localPath];
//                imageArray[i] = [UIImage imageNamed:fileData.filename];
//                [imageArray addObject:[UIImage imageNamed:fileData.filename]];
            }
            else{
                [imageArray addObject:[UIImage imageNamed:@"photo_frame.png"]];
            }
                
            
        }
        
    }
    [self.tableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)restClient:(DBRestClient *)client loadMetadataFailedWithError:(NSError *)error
{
    [self.tableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIAlertView *alertFailed = [[UIAlertView alloc]initWithTitle:@"Property Search Failed!"
                                                         message:[error localizedDescription]
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
    [alertFailed show];
}

#pragma mark - DBRestClientDelegate Methods for Download Data
- (void)restClient:(DBRestClient *)client loadedFile:(NSString *)localPath
       contentType:(NSString *)contentType metadata:(DBMetadata *)metadata
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@""
//                                                   message:@"File downloaded successfully."
//                                                  delegate:nil
//                                         cancelButtonTitle:@"OK"
//                                         otherButtonTitles:nil];
//    [alert show];
    [imageArray addObject:[UIImage imageNamed:localPath]];
    
}

-(void)restClient:(DBRestClient *)client loadFileFailedWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@""
//                                                   message:[error localizedDescription]
//                                                  delegate:nil
//                                         cancelButtonTitle:@"OK"
//                                         otherButtonTitles:nil];
//    [alert show];
}

#pragma mark - UITableView Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        return [self.searchResults count];
//    }else{
        return [searchedResult count];
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DropboxCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id_property_cell"];
    
    DBMetadata * metadata = [searchedResult objectAtIndex:indexPath.row];

    
//    [cell.btnIcon setTitle:metadata.path forState:UIControlStateDisabled];
//    [cell.btnIcon addTarget:self action:@selector(btnDownloadPress:) forControlEvents:UIControlEventTouchUpInside];
    
    if (metadata.isDirectory) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.imageView.image = [imageArray objectAtIndex:indexPath.row];
        
        cell.lblPcs.text = [NSString stringWithFormat:@"Folder"];
        
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.lblPcs.text = @"";
    }
    
//    cell.lblPcs.text = [NSString stringWithFormat:@"%lu pcs", [[countArray objectAtIndex:indexPath.row] integerValue]];
    
    cell.lblTitle.text = metadata.filename;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    cell.lblDate.text =  [formatter stringFromDate:metadata.lastModifiedDate];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    DropboxCell *cell = (DropboxCell*)[tableView cellForRowAtIndexPath:indexPath];
    if ([cell.lblPcs.text isEqualToString:@""]) {
        return;
    }
    DBMetadata *metadata = [searchedResult objectAtIndex:indexPath.row];
    
    DetailCollectionViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"id_detail_view_new"];
    vc.loadData = metadata.path;
    vc.strPropertyName = metadata.filename;
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/*
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *simpleTableIdentifier = @"id_property_cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    UILabel * lblTitle = (UILabel *) [cell viewWithTag:1];
//    UILabel * lblDate = (UILabel *) [cell viewWithTag:2];
    UILabel * lblPcs = (UILabel *) [cell viewWithTag:3];
    
    lblTitle.text = [NSString stringWithFormat:@"Property %lu", indexPath.row];
    lblPcs.text = [NSString stringWithFormat:@"%lu pcs", indexPath.row * 2];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailCollectionViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"id_detail_view"];
    [self.navigationController pushViewController:vc animated:YES];
    
}
 */

#pragma mark - search bar
/*
-(void)filterContentForSearchText:(NSString *)searchText scope:(NSString*)scope{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"filename contains[c] %@", searchText];
    
    DBMetadata *metadata;
    for(int i=0; i<[marrDownloadData count]; i++){
        metadata = [marrDownloadData objectAtIndex:i];
        [strArray addObject:metadata.filename];
    }
        
    self.searchResults = [strArray filteredArrayUsingPredicate:resultPredicate];
}
-(BOOL)searchDisplayController:(UISearchDisplayController*)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                                         objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}
 */

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
 //    NSLog(@"Hi");
    DBMetadata *metadata;

    
    [searchedResult removeAllObjects];
    for(metadata in marrDownloadData){
        if ([metadata.filename containsString:searchBar.text]) {
            [searchedResult addObject:metadata];
        }
    }
    if ([searchBar.text isEqual:@""]) {
        for(metadata in marrDownloadData){
            [searchedResult addObject:metadata];
        }
    }
    [self.tableView reloadData];
    
}
@end
