//
//  LoginViewController.m
//  Island Properties
//
//  Created by My Star on 2/12/16.
//  Copyright © 2016 David Roman. All rights reserved.
//

#import "LoginViewController.h"
#import <DropboxSDK/DropboxSDK.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    self.btnLogin.layer.cornerRadius = 2;
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

- (IBAction)btnLoginTapped:(id)sender {
    
    [[DBSession sharedSession] linkFromController:self];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
@end
