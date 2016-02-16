//
//  Contact.h
//  SidebarDemo
//
//  Created by Sonia Reddy Kolli on 02/15/16.
//  Copyright (c) 2016 Sonia Reddy Kolli. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Address;
@class ContactEmail;
@class CompanyDetails;

@interface Contact : NSObject

@property(nonatomic,strong) NSString *contactName;
@property(nonatomic,strong) NSString *contactPosition;
@property(nonatomic,strong) NSString *imageUrl;
@property(nonatomic,strong) NSString *homePage;
@property(nonatomic,strong) NSMutableArray *emails;
@property(nonatomic) NSInteger age;
@property(nonatomic,strong) Address *contactAddress;
@property(nonatomic,strong) NSMutableArray *phones;
@property(nonatomic,strong) CompanyDetails *company;

@end
