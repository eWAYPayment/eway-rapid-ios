//
//  ViewController.m
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "DashboardViewController.h"
#import "RapidAPI.h"
#import "NVpair.h"
#import "LineItem.h"
#import "EncryptViewController.h"
#import "PaymentViewController.h"
#import "UserMessageViewController.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Dashboard";
    
    
    dataSource = @[@"Encrypt", @"SubmitPayment",@"userMessage"];
    
    directions = @[[EncryptViewController class], [PaymentViewController class], [UserMessageViewController class]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - TableView DataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dashboardCell"];
    
    cell.textLabel.text = dataSource[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(directions[indexPath.row])];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
