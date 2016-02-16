//
//  LoginViewController.m
//  ContactSampleApp
//
//  Created by Sonia Reddy Kolli on 02/15/16.
//  Copyright (c) 2016 Sonia Reddy Kolli. All rights reserved.
//

#import "LoginViewController.h"
#import "NavigationController.h"
#import "HomeViewController.h"
#import "RootViewController.h"
#import "MenuViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize username,password;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLoginSuccess:(id)sender{
    
    if (username.text.length==0|| password.text.length ==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"Please enter valid username/password"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else{
        RootViewController *rtVC = (RootViewController*)self.view.window.rootViewController;
        
        NavigationController *demoNavVC = (NavigationController*)rtVC.contentViewController;
        HomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homeController"];
        
        [demoNavVC pushViewController:homeViewController animated:YES];
        
        
        self.frostedViewController.contentViewController = demoNavVC;
        [self.frostedViewController hideMenuViewController];
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

@end
