//
//  EncryptViewController.h
//  Rapid
//
//  Created by eWAY on 4/14/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputNVpairViewController.h"
#import "NVpair.h"
#import "RapidAPI.h"

@interface EncryptViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *TableView;
    NSMutableArray *arrNVpair;
}

@end
