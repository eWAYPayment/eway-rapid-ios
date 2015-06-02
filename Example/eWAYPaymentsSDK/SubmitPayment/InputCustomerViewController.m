//
//  InputCustomerViewController.m
//  Rapid
//
//  Created by eWAY on 4/15/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "InputCustomerViewController.h"

@implementation InputCustomerViewController

#pragma mark - lifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Customer";
    
    svContents.contentSize = CGSizeMake(svContents.frame.size.width, 900);
    
    //add button
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = addBtn;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.customerObj) {
        [self fetchData];
    }
    else self.customerObj = [[Customer alloc] init];
}

- (void)setTextfileTag:(NSInteger)tag text:(NSString *)text
{
    ((UITextField *)[svContents viewWithTag:tag]).text = text;
}

- (NSString *)textWithTfTag:(NSInteger)tag
{
    return ((UITextField *)[svContents viewWithTag:tag]).text;
}

- (void)fetchData
{
    [self setTextfileTag:1 text:self.customerObj.TokenCustomerID];
    [self setTextfileTag:2 text:self.customerObj.Reference];
    [self setTextfileTag:3 text:self.customerObj.Title];
    [self setTextfileTag:4 text:self.customerObj.FirstName];
    [self setTextfileTag:5 text:self.customerObj.LastName];
    [self setTextfileTag:6 text:self.customerObj.CompanyName];
    [self setTextfileTag:7 text:self.customerObj.JobDescription];
    [self setTextfileTag:8 text:self.customerObj.Phone];
    [self setTextfileTag:9 text:self.customerObj.Mobile];
    [self setTextfileTag:10 text:self.customerObj.Fax];
    [self setTextfileTag:11 text:self.customerObj.Url];
    [self setTextfileTag:12 text:self.customerObj.Comments];
}

#pragma mark - Action

- (void)done:(id)sender
{
    self.customerObj.TokenCustomerID  = [self textWithTfTag:1];
    self.customerObj.Reference  = [self textWithTfTag:2];
    self.customerObj.Title  = [self textWithTfTag:3];
    self.customerObj.FirstName  = [self textWithTfTag:4];
    self.customerObj.LastName  = [self textWithTfTag:5];
    self.customerObj.CompanyName  = [self textWithTfTag:6];
    self.customerObj.JobDescription  = [self textWithTfTag:7];
    self.customerObj.Phone  = [self textWithTfTag:8];
    self.customerObj.Mobile  = [self textWithTfTag:9];
    self.customerObj.Fax  = [self textWithTfTag:10];
    self.customerObj.Url = [self textWithTfTag:11];
    self.customerObj.Comments  = [self textWithTfTag:12];
    
    self.callback(self.customerObj);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickAddress:(id)sender
{
    InputAddressViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([InputAddressViewController class])];
    vc.addressObj = self.customerObj.Address;
    
    __weak typeof(self)weakSelf = self;
    vc.callback = ^ (Address *addressObject)
    {
        weakSelf.customerObj.Address = addressObject;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickCardDetails:(id)sender
{
    InputCardDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([InputCardDetailViewController class])];
    vc.cardDetailObj = self.customerObj.CardDetails;
    
    __weak typeof(self)weakSelf = self;
    vc.callBack = ^(CardDetails *cardetailObj){
        weakSelf.customerObj.CardDetails = cardetailObj;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

@end
