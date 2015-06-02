//
//  InputPaymentViewController.h
//  Rapid
//
//  Created by eWAY on 4/17/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Payment.h"

typedef void (^callBackPayment)(Payment *paymentObj);

@interface InputPaymentViewController : UIViewController
{
    IBOutlet UIScrollView *svContent;
    IBOutlet UITextField *tfPayment;
    IBOutlet UITextField *tfInvoiceNumber;
    IBOutlet UITextField *tfInvoiceDescription;
    IBOutlet UITextField *tfInvoiceReference;
    IBOutlet UITextField *tfCurrencyCode;
}

@property (nonatomic, strong) Payment *payment;
@property (nonatomic, copy) callBackPayment callback;

@end
