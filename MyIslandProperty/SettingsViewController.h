//
//  SettingsViewController.h
//  MyIslandProperty
//
//  Created by Adrian Rusin on 12/26/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>

@interface SettingsViewController : UITableViewController<DBRestClientDelegate>{
    DBRestClient *restClient;
    NSString *loadData;
    NSMutableArray *marrDownloadData;
    NSInteger nSelectedRow;
//    NSMutableArray *searchedResult;
//    NSMutableArray *imageArray;
//    NSMutableArray *countArray;
    
    
}
- (IBAction)btnDeleteTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnDelete;


@end
