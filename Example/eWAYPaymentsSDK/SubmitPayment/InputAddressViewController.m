//
//  InputAddressViewController.m
//  Rapid
//
//  Created by eWAY on 4/15/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "InputAddressViewController.h"

@implementation InputAddressViewController
@synthesize addressObj;


#pragma mark - lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Address";
    
    [self fakeData];
    
    svContent.contentSize = CGSizeMake(svContent.frame.size.width, svContent.frame.size.height);
    
    //add button
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = addBtn;
}

- (void)fakeData
{
    if (self.addressObj) {
        tfStreet1.text = addressObj.Street1;
        tfStreet2.text = addressObj.Street2;
        tfCity.text = addressObj.City;
        tfCountry.text = addressObj.Country;
        tfState.text = addressObj.State;
        tfPostCode.text = addressObj.PostalCode;
    }
    else
        self.addressObj = [[Address alloc] init];
    
}

- (void)done:(id)sender
{
    addressObj = [[Address alloc] init];
    addressObj.Street1 = tfStreet1.text;
    addressObj.Street2 = tfStreet2.text;
    addressObj.City = tfCity.text;
    addressObj.State = tfState.text;
    addressObj.Country = tfCountry.text;
    addressObj.PostalCode = tfPostCode.text;
   
    
    self.callback(addressObj);
    [self.navigationController popViewControllerAnimated:YES];
}

@end
