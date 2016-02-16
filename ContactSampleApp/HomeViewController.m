//
//  DEMOHomeViewController.m
//  REFrostedViewControllerStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "HomeViewController.h"
#import "Defines.h"
#import "Contact.h"
#import "Address.h"
#import "CompanyDetails.h"
#import "ContactEmail.h"
#import "ContactPhone.h"
#import "ContactCellTableViewCell.h"
#import "DetailViewController.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "MBProgressHUD.h"

@interface HomeViewController ()<MBProgressHUDDelegate>{
    
    NSMutableArray *userContacts;
    NSArray *searchResults;
    MBProgressHUD *HUD;
}
@end

@implementation HomeViewController

-(void)viewDidLoad{
    
    // No search results controller to display the search results in the current view
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    // Configure the search bar with scope buttons and add it to the table view header
    self.searchController.searchBar.scopeButtonTitles = nil;
    self.searchController.searchBar.delegate = self;
    
    self.contacts.tableHeaderView = self.searchController.searchBar;
    
    self.definesPresentationContext = NO;
    
    // The search bar does not seem to set its size automatically
    // which causes it to have zero height when there is no scope
    // bar. If you remove the scopeButtonTitles above and the
    // search bar is no longer visible make sure you force the
    // search bar to size itself (make sure you do this after
    // you add it to the view hierarchy).
    [self.searchController.searchBar sizeToFit];
    
    NSURL *url = [NSURL URLWithString:@"http://beta.json-generator.com/api/json/get/4yLVmeGYe"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
//    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    //    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"received response object = %@",responseObject);
        
        //Parse and save contacts
        for (NSDictionary *contactDict in responseObject) {
            Contact *tempItem = [[Contact alloc] init];
            tempItem.imageUrl = [contactDict valueForKey:KEY_IMAGEURL];
            tempItem.homePage = [contactDict valueForKey:KEY_HOMEPAGE];
            tempItem.contactName = [contactDict valueForKey:KEY_NAME];
            tempItem.contactPosition = [contactDict valueForKey:KEY_POSITION];
            tempItem.age = [[contactDict valueForKey:KEY_AGE] integerValue];
            
            
            //EMAILS
            tempItem.emails = [[NSMutableArray alloc] initWithCapacity:2];

            NSArray *emails = [contactDict valueForKey:KEY_EMAILS];
            for (NSDictionary *email in emails) {
                ContactEmail *userEmail = [[ContactEmail alloc] init];
                userEmail.type = [[email objectForKey:KEY_LABEL] isEqualToString:KEY_WORK]?Email_Work:Email_Personal;
                userEmail.email = [email objectForKey:KEY_EMAIL];
                [tempItem.emails addObject:userEmail];
            }
            
            
            //PHONES
            tempItem.phones = [[NSMutableArray alloc] initWithCapacity:2];
            
            NSArray *phones = [contactDict valueForKey:KEY_PHONE];
            for (NSDictionary *phone in phones) {
                ContactPhone *userPhone = [[ContactPhone alloc] init];
                userPhone.phoneNumber = [phone objectForKey:KEY_NUMBER];
                userPhone.type = [[phone objectForKey:KEY_TYPE] isEqualToString:KEY_MOBILE]?Mobile:Phone;
                [tempItem.phones addObject:userPhone];
            }
            
            //ADDRESS
            tempItem.contactAddress = [[Address alloc] init];
            NSArray *addressArry = [[NSArray alloc] initWithArray:[contactDict objectForKey:KEY_ADDRESS]];
            for (NSDictionary *addressDict in addressArry) {
                tempItem.contactAddress.address1 = [addressDict objectForKey:KEY_ADDRESS1];
                tempItem.contactAddress.address2 = [addressDict objectForKey:KEY_ADDRESS2];
                tempItem.contactAddress.address3 = [addressDict objectForKey:KEY_ADDRESS3];
                tempItem.contactAddress.city = [addressDict objectForKey:KEY_CITY];
                tempItem.contactAddress.state = [addressDict objectForKey:KEY_STATE];
                tempItem.contactAddress.zipCode = [[addressDict objectForKey:KEY_ZIP] stringValue];
                tempItem.contactAddress.country = [addressDict objectForKey:KEY_COUNTRY];
            }
            
            //COMPANY DETAILS
            tempItem.company = [[CompanyDetails alloc] init];
            NSDictionary *companyDet = [contactDict objectForKey:KEY_COMPDETAILS];
            tempItem.company.companyName = [companyDet objectForKey:KEY_NAME];
            tempItem.company.companyLocation = [companyDet objectForKey:KEY_LOCATION];
            
            if (nil == userContacts) {
                userContacts = [[NSMutableArray alloc] init];
            }
            
            [userContacts addObject:tempItem];
        }
        searchResults = [[NSArray alloc] initWithArray:userContacts];
        [HUD removeFromSuperview];
        [self.contacts reloadData];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"contact download failed   with reason = %@",error);
    }];
    
    [operation start];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.delegate = self;
    HUD.labelText = @"Fetching Contacts...";
    [HUD show:YES];

}

- (IBAction)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    if (nil == searchResults) {
        searchResults  = [[NSArray alloc] init];
    }
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    searchResults = [userContacts filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchController:(UISearchBar *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[controller scopeButtonTitles]
                                      objectAtIndex:[controller
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}



#pragma mark - UITableViewDelegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return searchResults.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //push your view controlle to move to next view controller
    NSLog(@"push view controller");
    DetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailVC.selectedContact = [searchResults objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ContactCellTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    Contact *contact = [searchResults objectAtIndex:indexPath.row];
    cell.textLabel.text = contact.contactName;
    return cell;
}


#pragma mark - UISearchResultsUpdating

//-(void)updateSearchResultsForSearchController{
//    
//    NSString *searchString = [self.searchBar text];
//    
//    [self filterContentForSearchText:searchString
//                               scope:[[self.searchBar scopeButtonTitles]
//                                      objectAtIndex:[self.searchBar
//                                                     selectedScopeButtonIndex]]];
//}

#pragma mark - UISearchBarDelegate

//// Workaround for bug: -updateSearchResultsForSearchController: is not called when scope buttons change
//- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
//    [self updateSearchResultsForSearchController];
//}

#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    HUD = nil;
}

#pragma mark -
#pragma mark === UISearchBarDelegate ===
#pragma mark -

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self updateSearchResultsForSearchController:self.searchController];
}

#pragma mark -
#pragma mark === UISearchResultsUpdating ===
#pragma mark -

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = searchController.searchBar.text;
    if (nil == searchString || [searchString isEqualToString:@""]) {
        searchResults = userContacts;
    }
    else{
        [self searchForText:searchString];
    }
    [self.contacts reloadData];
}

- (void)searchForText:(NSString *)searchText
{
//    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"%K BEGINSWITH[cd] %@",searchText];
//    searchResults = [userContacts filteredArrayUsingPredicate:bPredicate];
    

    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF.contactName contains[cd] %@",searchText];
    searchResults = [userContacts filteredArrayUsingPredicate:resultPredicate];
    
    NSLog(@"update search results");
}



@end
