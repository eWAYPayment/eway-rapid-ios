//
//  InputShippingDetailViewController.h
//  Rapid
//
//  Created by eWAY on 4/16/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShippingDetails.h"
#import "InputMethodTableViewController.h"

typedef void (^callBackShippingDetail)(ShippingDetails *shippingDetailObj);

@interface InputShippingDetailViewController : UIViewController
{
    IBOutlet UIScrollView *svContent;
    IBOutlet UITextField *tfFirstName;
    IBOutlet UITextField *tfLastName;
    IBOutlet UITextField *tfEmail;
    IBOutlet UITextField *tfPhone;
    IBOutlet UITextField *tfFax;
}

@property (nonatomic, strong) ShippingDetails *shippingDetail;
@property (nonatomic, copy) callBackShippingDetail callBack;

- (IBAction)clickAddress:(id)sender;
- (IBAction)clickMethod:(id)sender;

@end
