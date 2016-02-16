//
//  Defines.h
//  SidebarDemo
//
//  Created by Sonia Reddy Kolli on 02/15/16.
//  Copyright (c) 2016 Sonia Reddy Kolli. All rights reserved.
//

#ifndef Defines_h
#define Defines_h

typedef enum emailTypes
{
    Email_Work,
    Email_Personal

} EmailType;

typedef enum phoneTypes
{
    Mobile,
    Phone
    
} PhoneType;

#define KEY_EMAILS @"emails"
#define KEY_POSITION @"position"
#define KEY_ADDRESS @"address"
#define KEY_PHONE @"phone"
#define KEY_AGE @"age"
#define KEY_HOMEPAGE @"homePage"
#define KEY_IMAGEURL @"imageUrl"
#define KEY_NAME    @"name"
#define KEY_COMPDETAILS    @"companyDetails"
#define KEY_TYPE    @"type"
#define KEY_NUMBER    @"number"
#define KEY_LABEL    @"label"
#define KEY_EMAIL    @"email"

#define KEY_WORK    @"Work"
#define KEY_PERSONAL   @"Personal"

#define KEY_MOBILE    @"Mobile"

#define KEY_LOCATION @"location"

#define KEY_ADDRESS1 @"address1"
#define KEY_ADDRESS2 @"address2"
#define KEY_ADDRESS3 @"address3"
#define KEY_CITY @  "city"
#define KEY_COUNTRY @"country"
#define KEY_STATE   @"state"
#define KEY_ZIP   @"zipcode"


#endif
