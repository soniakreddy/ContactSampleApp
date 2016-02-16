//
//  ContactEmail.h
//  SidebarDemo
//
//  Created by Sonia Reddy Kolli on 02/15/16.
//  Copyright (c) 2016 Sonia Reddy Kolli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Defines.h"

@interface ContactEmail : NSObject

@property(nonatomic,strong) NSString *email;
@property(nonatomic) EmailType type;

@end
