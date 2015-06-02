//
//  InputMethodTableViewController.m
//  Rapid
//
//  Created by eWAY on 4/17/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "InputMethodTableViewController.h"

@interface InputMethodTableViewController ()

@end

@implementation InputMethodTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Shipping metthod";
    
    dataSource = [[NSArray alloc] initWithObjects:@"Unknown",
                  @"LowCost",
                  @"DesignatedByCustomer",
                  @"International",
                  @"Military",
                  @"NextDay",
                  @"StorePickup",
                  @"TwoDayService",
                  @"ThreeDayService",
                  @"Other", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shipping method" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shipping method"];
    }
    cell.textLabel.text = dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShippingMethod type;

    switch (indexPath.row) {
        case 0:
            type = Unknown;
            break;
        case 1:
            type = LowCost;
            break;
        case 2:
            type = DesignatedByCustomer;
            break;
        case 3:
            type = International;
            break;
        case 4:
            type = Military;
            break;
        case 5:
            type = NextDay;
            break;
        case 6:
            type = StorePickup;
            break;
        case 7:
            type = TwoDayService;
            break;
        case 8:
            type = ThreeDayService;
            break;
        case 9:
            type = Other;
            break;
        default:
            break;
    }
    self.callback (type);
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end