//
//  InputLineViewController.h
//  Rapid
//
//  Created by eWAY on 4/17/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineItem.h"

typedef void (^callBackLine)(LineItem *lineObj);

@interface InputLineViewController : UIViewController
{
    IBOutlet UIScrollView *svContent;
    IBOutlet UITextField *tfSKU;
    IBOutlet UITextField *tfQuantity;
    IBOutlet UITextField *tfDescription;
    IBOutlet UITextField *tfSUnitCost;
    IBOutlet UITextField *tfTax;
    IBOutlet UITextField *tfTotal;
}

@property (nonatomic, copy) callBackLine callback;


@end
