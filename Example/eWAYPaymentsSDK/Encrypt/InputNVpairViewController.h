//
//  InputNVpairViewController.h
//  Rapid
//
//  Created by eWAY on 4/14/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NVpair.h"

typedef void (^addNVpair)(NVpair *NVpair);

@interface InputNVpairViewController : UIViewController
{
    IBOutlet UITextField *tfName;
    IBOutlet UITextField *tfValue;
}

@property (nonatomic, copy) addNVpair clickSave;

- (IBAction)clickSave:(id)sender;

@end
