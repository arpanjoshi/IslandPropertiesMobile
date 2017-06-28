//
//  AddNewPropertyViewController.m
//  MyIslandProperty
//
//  Created by Adrian Rusin on 12/23/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "AddNewPropertyViewController.h"
#import "AddedViewController.h"
#import "MBProgressHUD.h"

@interface AddNewPropertyViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>{
    
    UITextField *textFieldIPANumber;
    UITextField *textField1;
    UITextField *textField2;
    UITextField *textField3;
    UITextField *textField4;
    UITextField *textField5;
    
    NSArray *arrStates;
    NSArray *arrPA;
}


@property (weak, nonatomic) IBOutlet UIButton *btnDropbox;
@property (weak, nonatomic) IBOutlet UIButton *btnLogout;

@end



@implementation AddNewPropertyViewController

@synthesize ipaOrAddress;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.ipaOrAddress == 1) {
        alertTitle = @"New IPA Property";
        alertMessage = @"Please enter IPA number for the property. This will be used for the folder name.";
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 30)];
        
        UITextField *textFieldPrefix = [[UITextField alloc] initWithFrame:CGRectMake(10,0,52,25)];
        textFieldPrefix.borderStyle = UITextBorderStyleRoundedRect;
        textFieldPrefix.text = @"IPA-";
        textFieldPrefix.enabled = FALSE;
        textFieldPrefix.delegate = self;
//        textField1.tag = 1;
        [v addSubview:textFieldPrefix];
        
        textFieldIPANumber = [[UITextField alloc] initWithFrame:CGRectMake(67,0,195,25)];
        textFieldIPANumber.placeholder = @"Enter IPA #";
        textFieldIPANumber.borderStyle = UITextBorderStyleRoundedRect;
        textFieldIPANumber.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        textFieldIPANumber.delegate = self;
        textFieldIPANumber.tag = 2;
        [v addSubview:textFieldIPANumber];
        
        
        alert = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Create", nil];
        [alert setValue:v  forKey:@"accessoryView"];
        alert.tag = 13;
//        [alert addButtonWithTitle:@"Create"];
        [alert show];
        
   }
    else{
        arrStates = [NSArray arrayWithObjects:@"Alabama-AL",    @"Alaska-AK",       @"Arizona-AZ",
                     @"Arkansas-AR",        @"California-CA",   @"Colorado-CO",     @"Connnecticut-CT",
                     @"Delaware-DE",        @"Florida-FL",      @"Georgia-GA",      @"Hawaii-HI",
                     @"Idaho-ID",           @"Illinois-IL",     @"Indiana-IN",      @"Iowa-IA",
                     @"Kansas-KS",          @"Kentucky-KY",     @"Louisiana-LA",    @"Maine-ME",
                     @"Maryland-MD",        @"Massachusetts-MA", @"Michigan-MI",    @"Minnesota-MN",
                     @"Mississippi-MS",     @"Missouri-MO",     @"Montana-MT",      @"Nebraska-NE",
                     @"Nevada-NV",          @"New Hampshire-NH", @"New Jersey-NJ",  @"New Mexico-NM",
                     @"New York-NY",        @"North Carolina-NC", @"North Dakota-ND", @"Ohio-OH",
                     @"Oklahoma-OK",        @"Oregon-OR",       @"Pennsylvania-PA", @"Rhode Island-RI",
                     @"South Carolina-SC",  @"South Dakota-SD", @"Tennessee-TN",    @"Texas-TX",
                     @"Utah-UT",            @"Vermont-VT",      @"Virginia-VA",     @"Washington-WA",
                     @"West Virginia-WV",   @"Wisconsin-WI",    @"Wyoming-WY", nil];
        
        arrPA = [NSArray arrayWithObjects:@"AL",    @"AK",       @"AZ",
                     @"AR",   @"CA",   @"CO",   @"CT",
                     @"DE",   @"FL",   @"GA",   @"HI",
                     @"ID",   @"IL",   @"IN",   @"IA",
                     @"KS",   @"KY",   @"LA",   @"ME",
                     @"MD",   @"MA",   @"MI",   @"MN",
                     @"MS",   @"MO",   @"MT",   @"NE",
                     @"NV",   @"NH",   @"NJ",   @"NM",
                     @"NY",   @"NC",   @"ND",   @"OH",
                     @"OK",   @"OR",   @"PA",   @"RI",
                     @"SC",   @"SD",   @"TN",   @"TX",
                     @"UT",   @"VT",   @"VA",   @"WA",
                     @"WV",   @"WI",   @"WY",   nil];
        
        alertTitle = @"New Address Property";
        alertMessage = @"Please enter Address for the property. This will be used for the folder name.";
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 200)];
        
        textField1 = [[UITextField alloc] initWithFrame:CGRectMake(10, 0,250,20)];
        textField1.borderStyle = UITextBorderStyleRoundedRect;
        textField1.placeholder = @"St.#";
        textField1.keyboardType = UIKeyboardTypeNumberPad;
        textField1.delegate = self;
        textField1.tag = 1;
        [v addSubview:textField1];
        
        textField2 = [[UITextField alloc] initWithFrame:CGRectMake(10,25,250,20)];
        textField2.placeholder = @"Street Name";
        textField2.borderStyle = UITextBorderStyleRoundedRect;
        textField2.keyboardType = UIKeyboardTypeDefault;
        textField2.delegate = self;
        textField2.tag = 2;
        [v addSubview:textField2];
        
        
        textField3 = [[UITextField alloc] initWithFrame:CGRectMake(10,50,250,20)];
        textField3.placeholder = @"City";
        textField3.borderStyle = UITextBorderStyleRoundedRect;
        textField3.keyboardType = UIKeyboardTypeAlphabet;
        textField3.delegate = self;
        textField3.tag = 3;
        [v addSubview:textField3];
        
        
        //uipicker for choosing state
        UIPickerView *pv = [[UIPickerView alloc]init];
        pv.dataSource = self; pv.delegate = self; pv.showsSelectionIndicator = YES;
        
        textField4 = [[UITextField alloc] initWithFrame:CGRectMake(10,75,250,20)];
        textField4.placeholder = @"State";
        textField4.borderStyle = UITextBorderStyleRoundedRect;
        textField4.inputView = pv;
        textField4.delegate = self;
        textField4.tag = 4;
        [v addSubview:textField4];
        
        
        textField5 = [[UITextField alloc] initWithFrame:CGRectMake(10, 100,250,20)];
        textField5.placeholder = @"ZIP code";
        textField5.borderStyle = UITextBorderStyleRoundedRect;
        textField5.keyboardType = UIKeyboardTypeNumberPad;
        textField5.delegate = self;
        textField5.tag = 5;
        [v addSubview:textField5];
        
//        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
//                                       initWithTitle:@"Done" style:UIBarButtonItemStyleDone
//                                       target:self action:@selector(done)];
//        UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-50, 320, 50)];
//        [toolBar setBarStyle:UIBarStyleBlackOpaque];
//        NSArray *toolbarItems = [NSArray arrayWithObjects:
//                                 doneButton, nil];
//        [toolBar setItems:toolbarItems];
        //        textField5.inputAccessoryView = toolBar;
        
//        [v addSubview:pv];
        
        
        alert = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Create", nil];
       
        [alert setValue:v  forKey:@"accessoryView"];
        
        alert.tag = 14;
        [alert show];
    
    }
    
//    if (!loadData) {
//        loadData = @"";
//    }
    
//    marrCreateFolderData = [[NSMutableArray alloc] init];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [self performSelector:@selector(fetchAllDropboxData) withObject:nil afterDelay:.1];
    
    
    //---------------
    CGSize buttonSize = self.btnDropbox.frame.size;
    NSString *buttonTitle = self.btnDropbox.titleLabel.text;
    CGSize titleSize = [buttonTitle sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:12.f] }];
    UIImage *buttonImage = self.btnDropbox.imageView.image;
    CGSize buttonImageSize = buttonImage.size;
    
    CGFloat offsetBetweenImageAndText = 0; //vertical space between image and text
    
    [self.btnDropbox setImageEdgeInsets:UIEdgeInsetsMake((buttonSize.height - (titleSize.height + buttonImageSize.height)) / 2 - offsetBetweenImageAndText,
                                                         (buttonSize.width - buttonImageSize.width) / 2,
                                                         0,0)];
    [self.btnDropbox setTitleEdgeInsets:UIEdgeInsetsMake((buttonSize.height - (titleSize.height + buttonImageSize.height)) / 2 + buttonImageSize.height + offsetBetweenImageAndText,
                                                         titleSize.width + [self.btnDropbox imageEdgeInsets].left > buttonSize.width ? -buttonImage.size.width  +  (buttonSize.width - titleSize.width) / 2 : (buttonSize.width - titleSize.width) / 2 - buttonImage.size.width,
                                                         0,0)];
    
    buttonSize = self.btnLogout.frame.size;
    buttonTitle = self.btnLogout.titleLabel.text;
    titleSize = [buttonTitle sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:12.f] }];
    buttonImage = self.btnLogout.imageView.image;
    buttonImageSize = buttonImage.size;
    
    
    [self.btnLogout setImageEdgeInsets:UIEdgeInsetsMake((buttonSize.height - (titleSize.height + buttonImageSize.height)) / 2 - offsetBetweenImageAndText,
                                                        (buttonSize.width - buttonImageSize.width) / 2,
                                                        0,0)];
    [self.btnLogout setTitleEdgeInsets:UIEdgeInsetsMake((buttonSize.height - (titleSize.height + buttonImageSize.height)) / 2 + buttonImageSize.height + offsetBetweenImageAndText,
                                                        titleSize.width + [self.btnLogout imageEdgeInsets].left > buttonSize.width ? -buttonImage.size.width  +  (buttonSize.width - titleSize.width) / 2 : (buttonSize.width - titleSize.width) / 2 - buttonImage.size.width,
                                                        0,0)];
    
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

//-(void)fetchAllDropboxData
//{
//    [self.restClient loadMetadata:loadData];
//}


#pragma mark - DBRestClientDelegate Methods for Load Data
//- (void)restClient:(DBRestClient*)client loadedMetadata:(DBMetadata *)metadata
//{
//    for (int i = 0; i < [metadata.contents count]; i++) {
//        DBMetadata *data = [metadata.contents objectAtIndex:i];
//        if (data.isDirectory) {
//            [marrCreateFolderData addObject:data];
//        }
//    }
////    [tbCreateFolder reloadData];
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
//}
//
//- (void)restClient:(DBRestClient *)client loadMetadataFailedWithError:(NSError *)error
//{
////    [tbCreateFolder reloadData];
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
//}

#pragma mark - DBRestClientDelegate Methods for Create Folder
- (void)restClient:(DBRestClient*)client createdFolder:(DBMetadata*)folder
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    UIAlertView *alertSuccess = [[UIAlertView alloc]initWithTitle:@""
//                                                   message:@"Folder created successfully."
//                                                  delegate:nil
//                                         cancelButtonTitle:@"OK"
//                                         otherButtonTitles:nil];
//    [alertSuccess show];
    // show the Added scene
    AddedViewController *s2 = [self.storyboard instantiateViewControllerWithIdentifier:@"id_added_new"];
    [self.navigationController pushViewController:s2 animated:YES];
    s2.navigationItem.hidesBackButton = TRUE;
    
    s2.strPropertyName = strPropertyName;
    s2.ipaOrAddress = self.ipaOrAddress;
}

- (void)restClient:(DBRestClient*)client createFolderFailedWithError:(NSError*)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    [self.navigationController popToRootViewControllerAnimated:YES];
    UIAlertView *alertFailed = [[UIAlertView alloc]initWithTitle:@"Property Creation Failed!"
                                                   message:[error localizedDescription]
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    [alertFailed show];
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
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 13) { //Creating using IPA Number
        
        if (buttonIndex == 1) {
            
//            UITextField *textfield = [alertView ];
            NSString *prefix = [NSString stringWithFormat:@"IPA-"];
            strPropertyName = [prefix stringByAppendingString:textFieldIPANumber.text];
            
            
            if ([textFieldIPANumber.text isEqualToString:@""]) {
                [textFieldIPANumber setBackgroundColor:[UIColor redColor]];
                [alert setMessage:@"Please enter IPA Number"];
                [alert show];
                return;
            }else{
                [textFieldIPANumber setBackgroundColor:[UIColor whiteColor]];
            }
            // creating a folder in dropbox
            [self createPropertyInDropbox];
            
        }
        else{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    
    }
    if (alertView.tag == 17) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    if (alertView.tag == 14) {   //Create using Address
        
        if (buttonIndex == 1) {
            NSString *msg = [NSString string];
            BOOL hasEmptyField = NO;
            BOOL notFiveDigits = NO;
            if ([textField1.text isEqualToString:@""]) {
                [textField1 setBackgroundColor:[UIColor redColor]];
                hasEmptyField = YES;
            }else{
                [textField1 setBackgroundColor:[UIColor whiteColor]];
            }
            if ([textField2.text isEqualToString:@""]) {
                [textField2 setBackgroundColor:[UIColor redColor]];
                hasEmptyField = YES;
            }else{
                [textField2 setBackgroundColor:[UIColor whiteColor]];
            }
            if ([textField3.text isEqualToString:@""]) {
                [textField3 setBackgroundColor:[UIColor redColor]];
                hasEmptyField = YES;
            }else{
                [textField3 setBackgroundColor:[UIColor whiteColor]];
            }
            if ([textField4.text isEqualToString:@""]) {
                [textField4 setBackgroundColor:[UIColor redColor]];
                hasEmptyField = YES;
            }else{
                [textField4 setBackgroundColor:[UIColor whiteColor]];
            }
            if ([textField5.text isEqualToString:@""]) {
                [textField5 setBackgroundColor:[UIColor redColor]];
                hasEmptyField = YES;
            }else{
                [textField5 setBackgroundColor:[UIColor whiteColor]];
            }
            if (textField5.text.length < 5) {
                [textField5 setBackgroundColor:[UIColor redColor]];
                notFiveDigits = YES;
            }else{
                [textField5 setBackgroundColor:[UIColor whiteColor]];
            }
            
            if(hasEmptyField){
                msg = @"Please fill in the red fields.";
            }
            if (notFiveDigits) {
                msg = [msg stringByAppendingString:@"\nZIP code should be 5-digit numeric!"];
            }
            if(hasEmptyField || notFiveDigits){
                [alert setMessage:msg];
                [alert show];
                
                return;
            }
   /*
            NSString *teamFolder = "/AVIN Team Folder";
            
            NSString *temp1 = [NSString stringWithFormat:@"%@.", textField1.text ];
            NSString *temp2 = [NSString stringWithFormat:@"%@.", textField2.text ];
            NSString *temp3 = [NSString stringWithFormat:@"%@.", textField3.text ];
            NSString *temp4 = [NSString stringWithFormat:@"%@.", textField4.text ];
 
            strPropertyName = [temp1 stringByAppendingString:temp2];
            strPropertyName = [strPropertyName stringByAppendingString:temp3];
            strPropertyName = [strPropertyName stringByAppendingString:temp4];
            strPropertyName = [strPropertyName stringByAppendingString:textField5.text];
            NSLog(@"%@", strPropertyName);
            */
            
            NSString *teamFolder = @"/AVIN Team Folder";
            
            
            NSString *temp1 = [NSString stringWithFormat:@"%@ ", textField1.text ];
            NSString *temp2 = [NSString stringWithFormat:@"%@ ", textField2.text ];
            NSString *temp3 = [NSString stringWithFormat:@"%@ ", textField3.text ];
            NSString *temp4 = [NSString stringWithFormat:@"%@ ", textField4.text ];
            
            strPropertyName = [teamFolder stringByAppendingString:temp1];
            
            strPropertyName = [temp1 stringByAppendingString:temp2];
            strPropertyName = [strPropertyName stringByAppendingString:temp3];
            strPropertyName = [strPropertyName stringByAppendingString:temp4];
            strPropertyName = [strPropertyName stringByAppendingString:textField5.text];
            NSLog(@"%@", strPropertyName);

            
            if ([strPropertyName isEqualToString:@""]) {
                [alert show];
                return;
            }
            
            [self createPropertyInDropbox];
            
        }
        else{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    }
}

NSString *teamFolder = @"/AVIN Team Folder";


-(void)createPropertyInDropbox{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.restClient createFolder:strPropertyName];
}

#pragma mark - UIPickerView datasource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [arrStates count];
}

#pragma mark - UIPickerView delegates
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED{
    return [arrStates objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED{
    [textField4 setText:[arrPA objectAtIndex:row]];
}


#pragma mark - UITextField delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == textField5) {
        if ((textField.backgroundColor == [UIColor redColor]) && (textField.text.length == 5)) {
            [textField setBackgroundColor:[UIColor whiteColor]];
        }
    }else{
        if((textField.backgroundColor == [UIColor redColor]) && (![textField.text isEqualToString:@""])){
            [textField setBackgroundColor:[UIColor whiteColor]];
        }
    }
    // Prevent crashing undo bug – see note below.
    if (textField != textField5) {
        return YES;
    }
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 5;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    if((textField.backgroundColor == [UIColor redColor]) && (![textField.text isEqualToString:@""])){
//        [textField setBackgroundColor:[UIColor whiteColor]];
//    }
}
@end
