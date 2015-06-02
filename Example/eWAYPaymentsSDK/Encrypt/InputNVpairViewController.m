//
//  InputNVpairViewController.m
//  Rapid
//
//  Created by eWAY on 4/14/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "InputNVpairViewController.h"


@implementation InputNVpairViewController

#pragma mark - lifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Input NVpair";
}

#pragma mark - Action

- (IBAction)clickSave:(id)sender
{
    if (![tfName.text isEqualToString:@""] && ![tfValue.text isEqualToString:@""]) {
        NVpair *nv = [[NVpair alloc] initWithDictionary:@{@"Name":tfName.text,@"Value":tfValue.text}];
        self.clickSave(nv);
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
