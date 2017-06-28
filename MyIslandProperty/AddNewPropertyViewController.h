//
//  AddNewPropertyViewController.h
//  MyIslandProperty
//
//  Created by Adrian Rusin on 12/23/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomAlertView.h"
#import <DropboxSDK/DropboxSDK.h>

@interface AddNewPropertyViewController : UIViewController<UITextFieldDelegate, UIAlertViewDelegate, DBRestClientDelegate>{
 
    UIAlertView *alert;
    NSString *alertTitle;
    NSString *alertMessage;
    NSString *strPropertyName;
    
    NSMutableArray *marrCreateFolderData;
    DBRestClient *restClient;
}
@property int ipaOrAddress;//1=ipa, 0=address, -1=null
@property (nonatomic, readonly) DBRestClient *restClient;
//@property (nonatomic, strong) NSString *loadData;

@end