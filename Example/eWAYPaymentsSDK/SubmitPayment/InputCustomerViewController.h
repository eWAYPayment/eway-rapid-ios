//
//  InputCustomerViewController.h
//  Rapid
//
//  Created by eWAY on 4/15/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Customer.h"
#import "InputAddressViewController.h"
#import "InputCardDetailViewController.h"

typedef void (^callBackCustomer)(Customer *customerObj);

@interface InputCustomerViewController : UIViewController
{
    IBOutlet UIScrollView *svContents;
}

@property (nonatomic, strong) Customer *customerObj;
@property (nonatomic, copy) callBackCustomer callback;

- (IBAction)clickAddress:(id)sender;

- (IBAction)clickCardDetails:(id)sender;

@end
