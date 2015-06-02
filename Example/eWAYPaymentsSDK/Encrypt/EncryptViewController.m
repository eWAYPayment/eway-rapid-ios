//
//  EncryptViewController.m
//  Rapid
//
//  Created by eWAY on 4/14/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "EncryptViewController.h"

@implementation EncryptViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Encrypt";
    
    arrNVpair = [NSMutableArray new];
    [self fakeData];
    
    //add button
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNVpair:)];
    self.navigationItem.rightBarButtonItem = addBtn;
}


- (void)fakeData
{
    NVpair *nvpair1 = [[NVpair alloc] init];
    nvpair1.name = @"cards";
    nvpair1.value = @"4444333322221111";
    
    NVpair *nvpair2 = [[NVpair alloc] init];
    nvpair2.name = @"CVN";
    nvpair2.value = @"123";
    
    [arrNVpair addObject:nvpair1];
    [arrNVpair addObject:nvpair2];
}

- (void)addNVpair:(id)sender
{
    InputNVpairViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([InputNVpairViewController class])];
    vc.clickSave = ^(NVpair *NVpair)
    {
        [arrNVpair addObject:NVpair];
        [TableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnSubmit:(id)sender
{
    SHOWLOADING(self.view)
    [RapidAPI encryptValues:arrNVpair completed:^(EncryptValuesResponse *encryptValuesResponse) {
        HIDELOADING(self.view)
        if (encryptValuesResponse.Status == Success) {
            NSMutableArray *arr = [NSMutableArray new];
            for (NVpair *nv in encryptValuesResponse.Values) {
                [arr addObject:[nv dictionary]];
            }
            
            NSString *msg = [NSString stringWithFormat:@"%@",arr];
            kCustomAlertWithParam(msg);
        }
        else {
            kCustomAlertWithParam(encryptValuesResponse.Errors);
        }
    }];
}

#pragma mark - UITableView DataSource & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else return arrNVpair.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 60.0;
    }
    return 82.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    switch (indexPath.section) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"SubmitCell"];
            UIButton *btnSubmit = (UIButton *)[cell viewWithTag:1];
            [btnSubmit addTarget:self action:@selector(clickBtnSubmit:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        }
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"EncryptCell"];
            
            NVpair *obj = arrNVpair[indexPath.row];
            
            UILabel *lbName = (UILabel *)[cell viewWithTag:1];
            UILabel *lbValue = (UILabel *)[cell viewWithTag:2];
            lbName.text = obj.name;
            lbValue.text = obj.value;
            break;
        }
        default:
            break;
    }
    
    return cell;
}

@end
