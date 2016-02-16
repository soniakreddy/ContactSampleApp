//
//  DetailViewController.m
//  ContactSampleApp
//
//  Created by Sonia Reddy Kolli on 02/15/16.
//  Copyright (c) 2016 Sonia Reddy Kolli. All rights reserved.
//

#import "DetailViewController.h"
#import "Defines.h"
#import "Contact.h"
#import "Address.h"
#import "CompanyDetails.h"
#import "ContactEmail.h"
#import "ContactPhone.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize selectedContact;
@synthesize Name, Age, PersonalEmail, WorkEmail,PersonalNumber, WorkNumber, HomePage, Street, City, State, Zipcode, CompanyLocation, CompanyName, ContactPosition, ProfilePic;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Name.text = selectedContact.contactName;
    Age.text = [NSString stringWithFormat:@"%li", (long)selectedContact.age];
    ContactEmail *personal = [selectedContact.emails objectAtIndex:0];
    PersonalEmail.text = personal.email;
    ContactEmail *work = [selectedContact.emails objectAtIndex:1];
    WorkEmail.text = work.email;
    ContactPhone *personalPhone = [selectedContact.phones objectAtIndex:0];
    PersonalNumber.text = personalPhone.phoneNumber;
    ContactPhone *workPhone = [selectedContact.phones objectAtIndex:1];
    WorkNumber.text =  workPhone.phoneNumber;
    HomePage.text = selectedContact.homePage;
    Street.text =  [NSString stringWithFormat:@"%@ %@ %@", selectedContact.contactAddress.address1, selectedContact.contactAddress.address2, selectedContact.contactAddress.address3];
    City.text = selectedContact.contactAddress.city;
    State.text = selectedContact.contactAddress.state;
    Zipcode.text = selectedContact.contactAddress.zipCode;
    CompanyName.text = selectedContact.company.companyName;
    CompanyLocation.text = selectedContact.company.companyLocation;
    ContactPosition.text = selectedContact.contactPosition;
    ProfilePic.image = [self getImageFromURL:selectedContact.imageUrl];
}
-(UIImage*) getImageFromURL:(NSString *)fileURL {
    UIImage *result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
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

@end
