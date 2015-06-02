
//
//  InputCardDetailViewController.m
//  Rapid
//
//  Created by eWAY on 4/15/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "InputCardDetailViewController.h"

@implementation InputCardDetailViewController
@synthesize cardDetailObj;

#pragma mark - lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Card Details";
    
    [self fakeData];
    
    svContent.contentSize = CGSizeMake(svContent.frame.size.width, svContent.frame.size.height);
    
    //add button
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = addBtn;
}

- (void)fakeData
{
    if (self.cardDetailObj) {
        tfName.text = cardDetailObj.Name;
        tfNumber.text = cardDetailObj.Number;
        tfExpiryMonth.text = cardDetailObj.ExpiryMonth;
        tfExpiryYear.text = cardDetailObj.ExpiryYear;
        tfStartMonth.text = cardDetailObj.StartMonth;
        tfStartYear.text = cardDetailObj.StartYear;
        tfIssueNumber.text = cardDetailObj.IssueNumber;
        tfCVN.text = cardDetailObj.CVN;
    }
    else
    {
        cardDetailObj = [[CardDetails alloc] init];
    }
    
    
}

- (void)done:(id)sender
{
    cardDetailObj = [[CardDetails alloc] init];
    cardDetailObj.Name = tfName.text;
    cardDetailObj.Number = tfNumber.text;
    cardDetailObj.ExpiryMonth = tfExpiryMonth.text;
    cardDetailObj.ExpiryYear = tfExpiryYear.text;
    cardDetailObj.StartMonth = tfStartMonth.text;
    cardDetailObj.StartYear = tfStartYear.text;
    cardDetailObj.IssueNumber = tfIssueNumber.text;
    cardDetailObj.CVN = tfCVN.text;
    
    self.callBack(cardDetailObj);
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
