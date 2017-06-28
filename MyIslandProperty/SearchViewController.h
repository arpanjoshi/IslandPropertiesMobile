//
//  SearchViewController.h
//  MyIslandProperty
//
//  Created by Adrian Rusin on 12/24/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>

@interface SearchViewController : UIViewController<DBRestClientDelegate, UISearchBarDelegate>{
    DBRestClient *restClient;
    NSString *loadData;
    NSMutableArray *marrDownloadData;
    
    NSMutableArray *searchedResult;
    NSMutableArray *imageArray;
    NSMutableArray *countArray;
    
    
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//@property(strong, nonatomic) NSMutableArray *searchResults;


@end
