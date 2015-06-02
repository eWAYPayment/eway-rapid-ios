//
//  InputMethodTableViewController.h
//  Rapid
//
//  Created by eWAY on 4/17/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Enumerated.h"

typedef void (^callBackShippingMethod) (ShippingMethod type);
@interface InputMethodTableViewController : UITableViewController
{
    NSArray *dataSource;
}

@property (nonatomic, copy) callBackShippingMethod callback;

@end
