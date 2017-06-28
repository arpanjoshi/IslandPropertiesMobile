//
//  UploadViewController.m
//  MyIslandProperty
//
//  Created by Adrian Rusin on 12/24/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "UploadViewController.h"
#import "ViewController.h"
#import "MBProgressHUD.h"

@interface UploadViewController ()
{
    NSMutableArray * selectedArray;
}
@end



@implementation UploadViewController
@synthesize strPropertyName, finalArray, btnTakePhoto;
+ (void)clearTmpDirectory
{
    NSArray* tmpDirectory = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL];
    for (NSString *file in tmpDirectory) {
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), file] error:NULL];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    nPics = 0;
    [UploadViewController clearTmpDirectory];
    self.collectionView.allowsMultipleSelection = TRUE;
    
    selectedArray = [NSMutableArray array];
    isImageUploading = FALSE;
    [self.btnUpload setEnabled:YES];
   
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
-(void)uploadFileToDropBox:(NSString *)uploadFileName
{
    NSString *desfilePath =[ NSString stringWithFormat:@"/%@", strPropertyName ];
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:uploadFileName];
    [self.restClient uploadFile:uploadFileName toPath:desfilePath withParentRev:@"" fromPath:filePath];
}

#pragma mark - DBRestClientDelegate Methods for Upload Data
-(void)restClient:(DBRestClient *)client uploadedFile:(NSString *)destPath from:(NSString *)srcPath
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (isImageUploading==TRUE) {
        isImageUploading = FALSE;
        UIAlertView *alertPhoto = [[UIAlertView alloc]initWithTitle:@"Success"
                                                              message:@"The photo uploaded successfully."
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
        [alertPhoto show];
    }
    
    nSuccess ++;
    if (nSuccess+nFailed == selectedArray.count) {
        self.btnUpload.enabled = true;
        strMessage = [NSString stringWithFormat:@"%i pictures uploaded successfully for %@, %i pictures failed.",nSuccess, strPropertyName, nFailed];
        alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:strMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 15;
        [alert show];
        
    }

}

-(void)restClient:(DBRestClient *)client uploadFileFailedWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    nFailed++;
    UIAlertView *alertFailed = [[UIAlertView alloc]initWithTitle:@""
                                                   message:[error localizedDescription]
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    [alertFailed show];
    
    if (nSuccess+nFailed == selectedArray.count) {
        self.btnUpload.enabled = true;
        strMessage = [NSString stringWithFormat:@"%i pictures uploaded successfully for %@, %i pictures failed.",nSuccess, strPropertyName, nFailed];
        alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:strMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 15;
        [alert show];
        
    }
}
//-------------------------------------------------------
- (void) viewWillAppear:(BOOL)animated {
    if (self.finalArray.count) {
        self.largeImageView.image = self.finalArray[0];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnUploadTapped:(id)sender {
//    UIButton *btnUpload = (UIButton *)sender;
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    self.btnUpload.enabled = FALSE;
    nPics = 0; nSuccess = 0; nFailed = 0;
//    NSString *filePath =[ NSString stringWithFormat:@"/%@", strPropertyName ];
    
//    [self.restClient uploadFile:@"FileName.png" toPath:filePath withParentRev:@"" fromPath:fromPath];
//    fromPath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Image.png"]
    nPics = 0;
    
    for (int i =0; i<selectedArray.count; i++){
        UIImage* img = [selectedArray objectAtIndex:i];
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyyMMdd_hhmmss"];
        NSString *temp = [dateFormatter stringFromDate:[NSDate date]];
        
        NSString *uploadfileName =[ NSString stringWithFormat:@"uploaded_%@_%d.jpg", temp, nPics++ ];
        NSData *data = UIImageJPEGRepresentation(img, 1);
        NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:uploadfileName];
        NSLog(@"uploadfileName: %@", uploadfileName);
        [data writeToFile:filePath atomically:YES];
//        [DBRestClient uploadFile:uploadfileName toPath:strPropertyName fromPath:file];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        [self.restClient uploadFile:uploadfileName toPath:filePath withParentRev:@"" fromPath:filePath];
        
        [self performSelector:@selector(uploadFileToDropBox:) withObject:uploadfileName afterDelay:.1];
        
//        [self uploadFileToDropBox:filePath];
    }
    
    
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ((alertView.tag == 111)&&(buttonIndex == 1)) {
 //       [self.navigationController popToRootViewControllerAnimated:YES];
        isImageUploading = TRUE;
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyyMMdd_hhmmss"];
        NSString *temp = [dateFormatter stringFromDate:[NSDate date]];
        
        NSString *uploadfileName =[ NSString stringWithFormat:@"uploaded_%@.jpg", temp];
        NSData *data = UIImageJPEGRepresentation(imagePhoto, 1);
        NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:uploadfileName];
        
        [data writeToFile:filePath atomically:YES];
        //        [DBRestClient uploadFile:uploadfileName toPath:strPropertyName fromPath:file];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //        [self.restClient uploadFile:uploadfileName toPath:filePath withParentRev:@"" fromPath:filePath];
        
        [self performSelector:@selector(uploadFileToDropBox:) withObject:uploadfileName afterDelay:.1];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//------

#pragma mark - UICollectionView DataSource
-(NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section{
//    NSLog(@"count = %lu", (unsigned long)finalArray.count);
    return finalArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"id_cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    imageView.image = [finalArray objectAtIndex:indexPath.row];
    
//    NSLog(@"hi");
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *searchTerm = self.searches[indexPath.section]; FlickrPhoto *photo =
//    self.searchResults[searchTerm][indexPath.row];
//    // 2
//    CGSize retval = photo.thumbnail.size.width > 0 ? photo.thumbnail.size : CGSizeMake(100, 100);
    return CGSizeMake(self.view.frame.size.width / 3 - 4, self.view.frame.size.width / 3 - 4);
}
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(2, 2, 2, 2);
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.largeImageView.image = [finalArray objectAtIndex:indexPath.row];
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath];
    cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"photo_frame.png"]];
    
    [selectedArray addObject:[finalArray objectAtIndex:indexPath.row]];
    
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath];
    cell.backgroundView = nil;
    [selectedArray removeObject:[finalArray objectAtIndex:indexPath.row]];
}


- (IBAction)btnTakePhotoTapped:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    
    // image picker needs a delegate,
    [imagePickerController setDelegate:self];
    
    // Place image picker on the screen
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

//delegate methode will be called after picking photo either from camera or library
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    imagePhoto = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSString *strPhoto = @"One photo is taken. Are you sure to upload it?";
    UIAlertView *alertPhoto = [[UIAlertView alloc] initWithTitle:@"Confirm" message:strPhoto delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK" ,nil];
    alertPhoto.tag = 111;
    [alertPhoto show];
    
}
@end
