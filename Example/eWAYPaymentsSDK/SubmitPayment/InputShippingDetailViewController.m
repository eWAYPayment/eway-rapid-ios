//
//  InputShippingDetailViewController.m
//  Rapid
//
//  Created by eWAY on 4/16/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "InputShippingDetailViewController.h"
#import "InputAddressViewController.h"

@implementation InputShippingDetailViewController

#pragma mark - lifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Shipping Details";
    
    [self fakeData];
    
    svContent.contentSize = CGSizeMake(svContent.frame.size.width, svContent.frame.size.height);
    
    //add button
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = addBtn;
}


#pragma mark - IBAction

- (void)fakeData
{
    if (self.shippingDetail) {
        tfFax.text = self.shippingDetail.Fax;
        tfEmail.text = self.shippingDetail.Email;
        tfFirstName.text = self.shippingDetail.FirstName;
        tfLastName.text = self.shippingDetail.LastName;
        tfPhone.text = self.shippingDetail.Phone;
    }
    else
    {
        self.shippingDetail = [[ShippingDetails alloc] init];
    }
   
}

- (void)done:(id)sender
{
    self.shippingDetail.FirstName = tfFirstName.text;
    self.shippingDetail.LastName = tfLastName.text;
    self.shippingDetail.Fax = tfFax.text;
    self.shippingDetail.Phone = tfPhone.text;
    self.shippingDetail.Email = tfEmail.text;
    
    self.callBack(self.shippingDetail);
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)clickAddress:(id)sender
{
    InputAddressViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([InputAddressViewController class])];
    vc.addressObj = self.shippingDetail.ShippingAddress;
    
    __weak typeof(self)weakSelf = self;
    vc.callback = ^ (Address *addressObject)
    {
        weakSelf.shippingDetail.ShippingAddress = addressObject;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickMethod:(id)sender
{
    InputMethodTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([InputMethodTableViewController class])];
    __weak typeof(self)weakSelf = self;
    vc.callback = ^(ShippingMethod type)
    {
        weakSelf.shippingDetail.ShippingMethod = type;
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
