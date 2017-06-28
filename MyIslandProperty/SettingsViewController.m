//
//  SettingsViewController.m
//  MyIslandProperty
//
//  Created by Adrian Rusin on 12/26/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "SettingsViewController.h"
#import "MBProgressHUD.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize btnDelete;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.btnDelete.enabled = FALSE;
    if (!loadData) {
        loadData = @"";
    }
    
    marrDownloadData = [[NSMutableArray alloc] init];
//    searchedResult = [[NSMutableArray alloc]init];
//    imageArray = [[NSMutableArray alloc]init];
//    countArray = [[NSMutableArray alloc]init];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self performSelector:@selector(fetchAllDropboxData) withObject:nil afterDelay:.1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//--------------
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
    
    for (int i = 0; i < [metadata.contents count]; i++) {
        //        j++;
        //        NSString *localDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        //
        DBMetadata *data = [metadata.contents objectAtIndex:i];
        //        NSString *filename = [NSString stringWithFormat:@"file%d.jpg", j];
        //        NSString *localPath = [localDir stringByAppendingPathComponent:filename];
        
        if (data.isDirectory) {
            [marrDownloadData addObject:data];
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
    //                                         cancelButtonTitle:@"Ok"
    //                                         otherButtonTitles:nil];
    //    [alert show];
//    [imageArray addObject:[UIImage imageNamed:localPath]];
    
}

-(void)restClient:(DBRestClient *)client loadFileFailedWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    //    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@""
    //                                                   message:[error localizedDescription]
    //                                                  delegate:nil
    //                                         cancelButtonTitle:@"Ok"
    //                                         otherButtonTitles:nil];
    //    [alert show];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [marrDownloadData count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id_cell_settings" forIndexPath:indexPath];
    
    // Configure the cell...
   // DropboxCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id_property_cell"];
    
    DBMetadata * metadata = [marrDownloadData objectAtIndex:indexPath.row];
    
    
    //    [cell.btnIcon setTitle:metadata.path forState:UIControlStateDisabled];
    //    [cell.btnIcon addTarget:self action:@selector(btnDownloadPress:) forControlEvents:UIControlEventTouchUpInside];
    
    if (metadata.isDirectory) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.imageView.image = [imageArray objectAtIndex:indexPath.row];
        
//        cell.lblPcs.text = [NSString stringWithFormat:@"Folder"];
        
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
//        cell.lblPcs.text = @"";
    }
    
    //    cell.lblPcs.text = [NSString stringWithFormat:@"%lu pcs", [[countArray objectAtIndex:indexPath.row] integerValue]];
    
    cell.textLabel.text = metadata.filename;
    cell.detailTextLabel.text = @"Folder";
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"MM/dd/yyyy"];
//    cell.lblDate.text =  [formatter stringFromDate:metadata.lastModifiedDate];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    nSelectedRow = indexPath.row;
    self.btnDelete.enabled = TRUE;
    
//    UITableViewCell *cell = (UITableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
//    if ([cell.lblPcs.text isEqualToString:@""]) {
//        return;
//    }
//    DBMetadata *metadata = [searchedResult objectAtIndex:indexPath.row];
//    
//    DetailCollectionViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"id_detail_view_new"];
//    vc.loadData = metadata.path;
//    [self.navigationController pushViewController:vc animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



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
#pragma mark - delete folder from dropbox - delegate methods
-(void)restClient:(DBRestClient*)client deletedPath:(NSString *)path{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [marrDownloadData removeObjectAtIndex:nSelectedRow];
    [self.tableView reloadData];
    self.btnDelete.enabled = FALSE;
    NSString *strMessage = [NSString stringWithFormat:@"%@ deleted successfully!", path ];
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Success" message:strMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [av show];
}

-(void)restClient:(DBRestClient*)client deletePathFailedWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Delete Failed" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [av show];
}
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

- (IBAction)btnDeleteTapped:(id)sender {
    DBMetadata *metadata = [marrDownloadData objectAtIndex:nSelectedRow];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.restClient deletePath:metadata.path];
    
}
@end
