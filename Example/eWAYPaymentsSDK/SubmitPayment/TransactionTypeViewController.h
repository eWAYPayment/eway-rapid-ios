//
//  TransactionTypeViewController.h
//  Rapid
//
//  Created by eWAY on 4/15/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Enumerated.h"

typedef void (^callBack)(TransactionType type);

@interface TransactionTypeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tbTransactionType;
    NSArray *datasource;
}

@property (nonatomic, copy) callBack callback;

@end
