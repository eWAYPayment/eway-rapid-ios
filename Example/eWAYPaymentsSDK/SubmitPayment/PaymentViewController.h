//
//  PaymentViewController.h
//  Rapid
//
//  Created by eWAY on 4/15/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"
#import "RapidAPI.h"
#import "TransactionTypeViewController.h"
#import "InputCustomerViewController.h"
#import "TransactionTypeViewController.h"
#import "InputShippingDetailViewController.h"
#import "InputPaymentViewController.h"
#import "LinesTableViewController.h"

#import "LineItem.h"

@interface PaymentViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tbTransaction;
    NSMutableArray *dataSource;
    NSMutableArray *directions;
}

@property (nonatomic, strong) Transaction *transaction;

@end
