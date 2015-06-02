//
//  InputAddressViewController.h
//  Rapid
//
//  Created by eWAY on 4/15/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"

typedef void (^callBackAddress)(Address *address);

@interface InputAddressViewController : UIViewController
{
    IBOutlet UIScrollView *svContent;
    IBOutlet UITextField *tfStreet1;
    IBOutlet UITextField *tfStreet2;
    IBOutlet UITextField *tfState;
    IBOutlet UITextField *tfCity;
    IBOutlet UITextField *tfCountry;
    IBOutlet UITextField *tfPostCode;
}

@property (nonatomic, strong) Address *addressObj;

@property (nonatomic, copy)callBackAddress callback;

@end
