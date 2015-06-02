//
//  LinesTableViewController.m
//  Rapid
//
//  Created by eWAY on 4/17/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "LinesTableViewController.h"

@interface LinesTableViewController ()

@end

@implementation LinesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Lines";
    
    //add button
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addLine:)];
    self.navigationItem.rightBarButtonItem = addBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action

- (void)addLine:(id)sender
{
    InputLineViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([InputLineViewController class])];
    
    __weak typeof(self)weakSelf = self;
    vc.callback = ^(LineItem *lineObj){
        [weakSelf.lines addObject:lineObj];
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnSubmit:(id)sender
{
    self.callBack(self.lines);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 1;
    return self.lines.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 60.0;
    }
    return 90.0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SubmitCell"];
        UIButton *btnSubmit = (UIButton *)[cell viewWithTag:1];
        [btnSubmit addTarget:self action:@selector(clickBtnSubmit:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"LineCell" forIndexPath:indexPath];
        LineItem *line = self.lines[indexPath.row];
        ((UILabel *)[cell viewWithTag:1]).text = [NSString stringWithFormat:@"SKU: %@",line.SKU];
        ((UILabel *)[cell viewWithTag:2]).text = [NSString stringWithFormat:@"Quantity: %d",line.Quantity];
        ((UILabel *)[cell viewWithTag:3]).text = [NSString stringWithFormat:@"Description: %@",line.Description];
        ((UILabel *)[cell viewWithTag:4]).text = [NSString stringWithFormat:@"UnitCost: %d",line.UnitCost];
        ((UILabel *)[cell viewWithTag:5]).text = [NSString stringWithFormat:@"Tax: %d",line.Tax];
        ((UILabel *)[cell viewWithTag:6]).text = [NSString stringWithFormat:@"Total: %d",line.Total];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
