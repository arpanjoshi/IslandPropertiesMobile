//
//  AddedViewController.m
//  MyIslandProperty
//
//  Created by Adrian Rusin on 12/23/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "AddedViewController.h"
#import "UploadViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"

@interface AddedViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelSuccess;
@property (weak, nonatomic) IBOutlet UILabel *labelAddPics;
@property (weak, nonatomic) IBOutlet UILabel *labelSuccess2;


@end

//static int count=0;

@implementation AddedViewController
@synthesize strPropertyName;
@synthesize ipaOrAddress;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.ipaOrAddress == 1) {
        self.labelSuccess.text = [NSString stringWithFormat:@"IPA Property # %@ added successfully", strPropertyName];
        self.labelAddPics.text = [NSString stringWithFormat:@"Add Pics for %@", strPropertyName];
    }
    else{
        self.labelSuccess.text = [NSString stringWithFormat:@"Address Property # %@ added successfully", strPropertyName];
        self.labelAddPics.text = [NSString stringWithFormat:@"Add Pics for Address-%@", strPropertyName];
    }
//    self.labelSuccess2.text = [NSString stringWithFormat:@ "added successfully"];
    
    self.labelSuccess.textColor = [UIColor whiteColor];
    self.labelAddPics.textColor = [UIColor whiteColor];
//    self.labelSuccess2.textColor = [UIColor whiteColor];
    
    [self getAllPictures];
}
- (IBAction)btnDoneTapped:(id)sender {
//    ViewController *s2 = [self.storyboard instantiateViewControllerWithIdentifier:@"id_root_controller"];
//    s2.navigationItem.hidesBackButton = true;
//    [self showViewController:s2 sender:self];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UploadViewController *controller = [segue destinationViewController];
    controller.strPropertyName = self.strPropertyName;
    controller.finalArray  = [[NSArray alloc]initWithArray:finalArray];
//    finalArray = nil;
 
}
//----- getting all images from photo library
-(void)getAllPictures
{
    finalArray = nil;
    finalArray = [[NSMutableArray alloc]init];
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    for (int i=0; i<10; i++) {
        [self loadImageFromIndex:i withAssetLibrary:(ALAssetsLibrary*)assetsLibrary];
    }
}
- (void)loadImageFromIndex:(int)index withAssetLibrary:(ALAssetsLibrary*)library {
    
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        // Within the group enumeration block, filter to enumerate your photos.
        [group setAssetsFilter:[ALAssetsFilter allPhotos]];
        long temp = [group numberOfAssets]-1-index;
        //if index exceeds bounds, kill the method
        if (temp < 0 || temp > [group numberOfAssets]-1) {
            return;
        }
        
        // Chooses the photo at the index
        [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:temp] options:0 usingBlock:^(ALAsset *alAsset, NSUInteger inde, BOOL *innerStop) {
            // The end of the enumeration is signaled by asset == nil.
            
            if (alAsset) {
                ALAssetRepresentation *representation = [alAsset defaultRepresentation];
                UIImage *tempImage = [UIImage imageWithCGImage:[representation fullScreenImage]];
                
                // Do something with the image
                [finalArray addObject:tempImage];
//                tempImage = nil;
                *stop = YES; *innerStop = YES;
                
            }
        }];
    }
     
    failureBlock: ^(NSError *error) {
        NSLog(@"None");
    }];
}

//-(void)allPhotosCollected:(NSArray*)imgArray
//{
//    //write your code here after getting all the photos from library...
//    finalArray = [[NSMutableArray alloc]init];
//    for (UIImage* element in imgArray) {
//        [finalArray addObject: element];
//    }
////    [AppDelegate sharedAppDelegate].imageArray = imgArray;
//    
////    NSLog(@"all pictures are %@",finalArray);
////    NSLog(@"count = %lu", (unsigned long)finalArray.count);
//}


@end
