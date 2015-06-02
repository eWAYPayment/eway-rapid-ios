//
//  InputCardDetailViewController.h
//  Rapid
//
//  Created by eWAY on 4/15/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardDetails.h"

typedef void (^callBackCardDetails)(CardDetails *cardDetailObj);

@interface InputCardDetailViewController : UIViewController
{
   
    IBOutlet UIScrollView *svContent;
    IBOutlet UITextField *tfName;
    IBOutlet UITextField *tfNumber;
    IBOutlet UITextField *tfExpiryMonth;
    IBOutlet UITextField *tfExpiryYear;
    IBOutlet UITextField *tfStartMonth;
    IBOutlet UITextField *tfStartYear;
    IBOutlet UITextField *tfIssueNumber;
    IBOutlet UITextField *tfCVN;
    
}


@property (nonatomic, copy) callBackCardDetails callBack;
@property (nonatomic, strong) CardDetails *cardDetailObj;

@end
