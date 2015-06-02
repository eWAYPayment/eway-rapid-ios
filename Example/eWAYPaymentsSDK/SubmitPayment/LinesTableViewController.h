//
//  LinesTableViewController.h
//  Rapid
//
//  Created by eWAY on 4/17/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineItem.h"
#import "InputLineViewController.h"


typedef void (^callBackLines)(NSMutableArray *arr);

@interface LinesTableViewController : UITableViewController


@property (nonatomic, strong) NSMutableArray *lines;
@property (nonatomic, copy) callBackLines callBack;

@end
