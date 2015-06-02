//
//  InputPaymentViewController.m
//  Rapid
//
//  Created by eWAY on 4/17/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "InputPaymentViewController.h"

@implementation InputPaymentViewController

#pragma mark - lifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Payment";
    
    [self fakeData];
    
    svContent.contentSize = CGSizeMake(svContent.frame.size.width, svContent.frame.size.height);
    
    //add button
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = addBtn;
}


#pragma mark - IBAction

- (void)fakeData
{
    if (self.payment) {
        tfPayment.text = [NSString stringWithFormat:@"%d",self.payment.Payment];
        tfCurrencyCode.text = self.payment.CurrencyCode;
        tfInvoiceDescription.text = self.payment.InvoiceDescription;
        tfInvoiceNumber.text= self.payment.InvoiceNumber;
        tfInvoiceReference.text = self.payment.InvoiceReference;
    }
    else
    {
        self.payment = [[Payment alloc] init];
    }
    
}

- (void)done:(id)sender
{
    @try {
        self.payment.CurrencyCode = tfCurrencyCode.text;
        self.payment.InvoiceReference = tfInvoiceReference.text;
        self.payment.InvoiceNumber = tfInvoiceNumber.text;
        self.payment.InvoiceDescription = tfInvoiceDescription.text;
        self.payment.Payment = [tfPayment.text intValue];
    }
    @catch (NSException *exception) {
        self.payment.Payment = 0;
    }
    @finally {
        self.callback(self.payment);
        [self.navigationController popViewControllerAnimated:YES];
    }
    

    
}

@end
