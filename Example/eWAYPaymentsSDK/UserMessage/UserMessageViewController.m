//
//  UserMessageViewController.m
//  Rapid
//
//  Created by eWAY on 4/15/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "UserMessageViewController.h"
#import "RapidAPI.h"

@implementation UserMessageViewController

#pragma mark - lifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"User Message";
    
    [self fakeData];
}

- (void)fakeData
{
    tfErrorsCode.text = @"V6023,V6068";
    tfLanguage.text = @"EN";
}


- (IBAction)clickSubmit:(id)sender
{
    SHOWLOADING(self.view)
    
    if (![tfLanguage.text isEqualToString:@""] && ![tfErrorsCode.text isEqualToString:@""]) {
        [RapidAPI userMessage:tfErrorsCode.text Language:tfLanguage.text completed:^(UserMessageResponse *userMessageResponse) {
            NSString *msg = [NSString stringWithFormat:@"%@ \n %@",userMessageResponse.Errors, userMessageResponse.Messages];
            HIDELOADING(self.view)
            kCustomAlertWithParam(msg); 
        }];
    }
    else
    {
        HIDELOADING(self.view)
    }
}

@end
