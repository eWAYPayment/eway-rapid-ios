//
//  UserMessageViewController.h
//  Rapid
//
//  Created by eWAY on 4/15/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserMessageViewController : UIViewController
{
    IBOutlet UITextField *tfLanguage;
    IBOutlet UITextField *tfErrorsCode;
}

- (IBAction)clickSubmit:(id)sender;

@end
