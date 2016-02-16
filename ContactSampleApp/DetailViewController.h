//
//  DetailViewController.h
//  ContactSampleApp
//
//  Created by Sonia Reddy Kolli on 02/15/16.
//  Copyright (c) 2016 Sonia Reddy Kolli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@interface DetailViewController : UIViewController

@property(nonatomic,strong) Contact *selectedContact;
@property(nonatomic,strong) IBOutlet  UILabel  *Name;
@property(nonatomic,strong) IBOutlet  UILabel  *Age;
@property(nonatomic,strong) IBOutlet  UILabel  *PersonalEmail;
@property(nonatomic,strong) IBOutlet  UILabel  *WorkEmail;
@property(nonatomic,strong) IBOutlet  UILabel  *PersonalNumber;
@property(nonatomic,strong) IBOutlet  UILabel  *WorkNumber;
@property(nonatomic,strong) IBOutlet  UILabel  *HomePage;
@property(nonatomic,strong) IBOutlet  UILabel  *Street;
@property(nonatomic,strong) IBOutlet  UILabel  *City;
@property(nonatomic,strong) IBOutlet  UILabel  *State;
@property(nonatomic,strong) IBOutlet  UILabel  *Zipcode;
@property(nonatomic,strong) IBOutlet  UILabel  *CompanyLocation;
@property(nonatomic,strong) IBOutlet  UILabel  *CompanyName;
@property(nonatomic,strong) IBOutlet  UILabel  *ContactPosition;
@property(nonatomic,strong) IBOutlet  UIImageView  *ProfilePic;

@end
