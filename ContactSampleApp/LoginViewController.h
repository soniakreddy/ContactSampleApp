//
//  LoginViewController.h
//  ContactSampleApp
//
//  Created by Sonia Reddy Kolli on 02/15/16.
//  Copyright (c) 2016 Sonia Reddy Kolli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UIAlertViewDelegate>
@property(nonatomic,strong) IBOutlet  UITextField  *username;
@property(nonatomic,strong) IBOutlet  UITextField  *password;

@end
