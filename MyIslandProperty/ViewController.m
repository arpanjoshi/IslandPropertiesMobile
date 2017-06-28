//
//  ViewController.m
//  MyIslandProperty
//
//  Created by Adrian Rusin on 12/23/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "ViewController.h"
#import "AddNewPropertyViewController.h"
#import "SearchViewController.h"
#import <DropboxSDK/DropboxSDK.h>
#import "SettingsViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnDropbox;
@property (weak, nonatomic) IBOutlet UIButton *btnLogout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    loggedIn = FALSE;
    // Do any additional setup after loading the view, typically from a nib.
    
//    alert = [[UIAlertView alloc] initWithTitle:@"LOG IN" message:@"Please enter your username and password:" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    
//    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
//    alert.tag = 12;
    
    //[alert addButtonWithTitle:@"Go"];
//    [alert show];
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
    
   if (![[DBSession sharedSession] isLinked]) {
       self.btnDropbox.hidden = YES;
       self.btnLogout.hidden = YES;
        [[DBSession sharedSession] linkFromController:self];
        NSLog(@"Not Linked!");
    }
    else{
        NSLog(@"Linked!");    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dropboxLoginDone) name:@"OPEN_DROPBOX_VIEW" object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    if (![[DBSession sharedSession] isLinked]) {
        self.btnDropbox.hidden = YES;
        self.btnLogout.hidden = YES;
        NSLog(@"Not Linked!");
    }
    else{
        self.btnDropbox.hidden = NO;
        self.btnLogout.hidden = NO;
        NSLog(@"Linked!");
    }
}
-(void)dropboxLoginDone
{
    self.btnDropbox.hidden = NO;
    self.btnLogout.hidden = NO;
    UIAlertView *alertLoginDone = [[UIAlertView alloc] initWithTitle:nil message:@"User logged in successfully." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertLoginDone show];
}



- (IBAction)onDropbox:(id)sender {
}
- (IBAction)onLogout:(id)sender {
    [[DBSession sharedSession] unlinkAll];
//    exit(0);
}
//- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    if (alertView.tag == 12) {
//        if (buttonIndex == 1) {
//        UITextField *textfieldName = [alertView textFieldAtIndex:0];
//        UITextField *textfieldPassword = [alertView textFieldAtIndex:1];
//        
//        if ([textfieldName.text isEqualToString:@"david"] && [textfieldPassword.text isEqualToString:@"1234"]) {
//            UIAlertView *welcomeView = [[UIAlertView alloc]initWithTitle:@"LOGGED IN" message:@"Welcome!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [welcomeView show];
//        }
//        else{
//            [alert show];
//        }

//            NSLog(@"username: %@", textfield.text);
//        }
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
//    AddNewPropertyViewController *destViewController = segue.destinationViewController;
//    if (![[DBSession sharedSession] isLinked]) {
//        [[DBSession sharedSession] linkFromController:self];
//        NSLog(@"Not Linked!");
//    }
//    else{
//        if ([segue.identifier isEqual:@"segueIPA"]) {
//            destViewController.ipaOrAddress = 1;
//        }
//        else if ([segue.identifier isEqual:@"segueAddress"]){
//            destViewController.ipaOrAddress = 0;
//        }
//    }
}


- (IBAction)btnIPATapped:(id)sender {
    if (![[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] linkFromController:self];
        NSLog(@"Not Linked!");
    }
    else{
        AddNewPropertyViewController *s2 = [self.storyboard instantiateViewControllerWithIdentifier:@"id_add_new_property"];
        s2.ipaOrAddress = 1;
        [self.navigationController pushViewController:s2 animated:YES];
        
    }
    
}

- (IBAction)btnSettingsTapped:(id)sender {
    if (![[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] linkFromController:self];
        NSLog(@"Not Linked!");
    }
    else{
        SettingsViewController *s2 = [self.storyboard instantiateViewControllerWithIdentifier:@"id_settings"];
        [self.navigationController pushViewController:s2 animated:YES];
        
    }

}

- (IBAction)btnAddressTapped:(id)sender {
    if (![[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] linkFromController:self];
        NSLog(@"Not Linked!");
    }
    else{
        AddNewPropertyViewController *s2 = [self.storyboard instantiateViewControllerWithIdentifier:@"id_add_new_property"];
        s2.ipaOrAddress = 0;
        [self.navigationController pushViewController:s2 animated:YES];
        
   }
}

- (IBAction)btnSearchTapped:(id)sender {
    if (![[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] linkFromController:self];
        NSLog(@"Not Linked!");
    }
    else{
        SearchViewController *s2 = [self.storyboard instantiateViewControllerWithIdentifier:@"id_search"];
        [self.navigationController pushViewController:s2 animated:YES];
        
//        s2.ipaOrAddress = 1;
    }
}
@end
