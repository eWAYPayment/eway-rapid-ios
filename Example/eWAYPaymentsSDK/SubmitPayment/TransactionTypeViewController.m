//
//  TransactionTypeViewController.m
//  Rapid
//
//  Created by eWAY on 4/15/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "TransactionTypeViewController.h"

@implementation TransactionTypeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Transaction Type";
    
    datasource = @[@"Purchase",@"Recurring", @"MOTO"];
}

#pragma mark - UItableview DataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellTransactionType"];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellTransactionType"];
    
    cell.textLabel.text = datasource[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TransactionType type = MOTO;
    if ([datasource[indexPath.row] isEqualToString:@"Purchase"]) {
        type = Purchase;
    }
    if ([datasource[indexPath.row] isEqualToString:@"Recurring"]) {
        type = Recurring;
    }
   
    self.callback(type);
    [self.navigationController popViewControllerAnimated:YES];
}

@end
