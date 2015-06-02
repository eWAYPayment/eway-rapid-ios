//
//  PaymentViewController.m
//  Rapid
//
//  Created by eWAY on 4/15/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "PaymentViewController.h"

@implementation PaymentViewController
@synthesize transaction;

#pragma mark - lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"SubmitPayment";
    
    dataSource = [NSMutableArray new];
    [dataSource addObject:@"TransactionType"];
    [dataSource addObject:@"Customer"];
    [dataSource addObject:@"ShippingDetails"];
    [dataSource addObject:@"Payment"];
    [dataSource addObject:@"LineItems"];
    [dataSource addObject:@"Options"];
    [dataSource addObject:@"PartnerID"];
    
    directions = [NSMutableArray new];
    [directions addObject:[TransactionTypeViewController class]];
    [directions addObject:[InputCustomerViewController class]];
    
    [self fakeData];
}

- (void)fakeData
{
    transaction = [[Transaction alloc] init];
    
    //fake customer
    Customer *customerObj = [[Customer alloc] init];
    customerObj.Reference = @"A12345";
    customerObj.Title = @"Mr.";
    customerObj.FirstName = @"John";
    customerObj.LastName = @"Smith";//
    customerObj.CompanyName = @"Demo Shop 123";
    customerObj.JobDescription = @"Developer";
    customerObj.Phone = @"09 889 0986";
    customerObj.Mobile = @"09 889 0986";
    customerObj.Comments = @"";
    customerObj.Fax = @"";
    customerObj.Url = @"";
    
    Address *customerAddress = [[Address alloc] init];
    customerAddress.Street1 = @"Level 5";
    customerAddress.Street2 = @"369 Queen Street";
    customerAddress.City = @"Auckland";
    customerAddress.State = @"";
    customerAddress.PostalCode = @"1010";
    customerAddress.Country = @"au";
    
    customerObj.Address = customerAddress;
    
    CardDetails *cardDetails = [[CardDetails alloc] init];
    cardDetails.Name = @"sanjay REST-JSON-SOAPUI";
    cardDetails.Number = @"4444333322221111";
    cardDetails.ExpiryMonth = @"12";
    cardDetails.ExpiryYear = @"16";
    cardDetails.StartMonth = @"";
    cardDetails.StartYear = @"";
    cardDetails.CVN = @"123";
    customerObj.CardDetails = cardDetails;
    
    transaction.Customer = customerObj;
    
    //add ShippingAddress
    ShippingDetails *shippingAddress = [[ShippingDetails alloc] init];
    shippingAddress.FirstName = @"John";
    shippingAddress.LastName = @"Smith";
    
    Address *shipAddress = [[Address alloc] init];
    shipAddress.Street1 = @"Level 5";
    shipAddress.Street2 = @"369 Queen Street";
    shipAddress.City = @"Auckland";
    shipAddress.State = @"";
    shipAddress.PostalCode = @"1010";
    shipAddress.Country = @"nz";
    shippingAddress.ShippingAddress = shipAddress;
    
    shippingAddress.Phone = @"09 889 0986";
    transaction.ShippingDetails = shippingAddress;
    
    NSMutableArray *items = [NSMutableArray new];
    for (NSInteger ii = 0 ; ii < 3 ; ii ++) {
        LineItem *obj = [[LineItem alloc] init];
        obj.SKU = [NSString stringWithFormat:@"SKU%ld",(long)ii];
        obj.Description = [NSString stringWithFormat:@"Description%ld",(long)ii];
        obj.Quantity = 1;
        obj.UnitCost = 1;
        obj.Tax = 0;
        obj.Total = 1;
        [items addObject:obj];
    }
    transaction.LineItems = items;
    
    NSMutableArray *Options = [NSMutableArray new];
    [Options addObject:@{@"Value":@"Option1"}];
    [Options addObject:@{@"Value":@"Option2"}];
    [Options addObject:@{@"Value":@"Option3"}];
    
    transaction.Options = Options;
    
    //payment
    Payment *payment = [[Payment alloc] init];
    payment.Payment = 100;
    payment.InvoiceNumber = @"Inv 21540";
    payment.InvoiceDescription = @"Individual Invoice Description";
    payment.InvoiceReference = @"513456";
    payment.CurrencyCode = @"AUD";
    
    transaction.Payment = payment;
    
    transaction.PartnerID = @"04A0FD665F7348A295C5B9EE95400301";
}


- (void)clickBtnSubmit:(id)sender
{
    SHOWLOADING(self.view)
    NSDate *methodStart = [NSDate date];
    [RapidAPI submitPayment:transaction completed:^(SubmitPaymentResponse *submitPaymentResponse) {
        NSString *msg = [NSString stringWithFormat:@"%@",@{@"Errors":submitPaymentResponse.Errors,@"SubmissionID":submitPaymentResponse.SubmissionID, @"Status":[NSString stringWithFormat:@"%lu",(unsigned long)submitPaymentResponse.Status]}];
      
        NSDate *methodFinish = [NSDate date];
        NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:methodStart];
        NSLog(@"executionTime = %f %@", executionTime, msg);
        HIDELOADING(self.view)
        kCustomAlertWithParam(msg);
        
        
    }];
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( section == 0) {
        return 1;
    }
    else
    {
        return dataSource.count;
    }
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
            cell = [tableView dequeueReusableCellWithIdentifier:@"cellPayment"];
            
            cell.textLabel.text = dataSource[indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        default:
            break;
    }
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        switch (indexPath.row) {
                case 0:
            {
                TransactionTypeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([TransactionTypeViewController class])];
                
                __weak typeof(self)weakSelf = self;
                vc.callback = ^(TransactionType type)
                {
                    weakSelf.transaction.TransactionType = type;
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                InputCustomerViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([InputCustomerViewController class])];
                vc.customerObj = transaction.Customer;
                
                __weak typeof(self)weakSelf = self;
                vc.callback = ^(Customer *customer)
                {
                    weakSelf.transaction.Customer = customer;
                };
                
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                case 2:
            {
                InputShippingDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([InputShippingDetailViewController class])];
                vc.shippingDetail = transaction.ShippingDetails;
                __weak typeof(self)weakSelf = self;
                vc.callBack = ^(ShippingDetails *shippingObj)
                {
                    weakSelf.transaction.ShippingDetails = shippingObj;
                };
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
                case 3 :
            {
                InputPaymentViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([InputPaymentViewController class])];
                vc.payment = self.transaction.Payment;
                
                __weak typeof(self)weakSelf = self;
                vc.callback = ^(Payment *payment)
                {
                    weakSelf.transaction.Payment = payment;
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 4:
            {
                LinesTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([LinesTableViewController class])];
                vc.lines = [[NSMutableArray alloc] initWithArray:self.transaction.LineItems];
                
                __weak typeof(self)weakSelf = self;
                vc.callBack = ^(NSMutableArray *arr)
                {
                    weakSelf.transaction.LineItems = [[NSArray alloc] initWithArray:arr];
                };
                
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 5:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Options" message:@"Enter Options:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
                UITextField * alertTextField = [alertView textFieldAtIndex:0];
                alertTextField.secureTextEntry = NO;
                alertTextField.text = [self.transaction.Options componentsJoinedByString:@","];
                
                [alertView show];
            }
                break;
            case 6:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"PartnerID" message:@"Enter PartnerID:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
                UITextField * alertTextField = [alertView textFieldAtIndex:0];
                alertTextField.secureTextEntry = YES;
                alertTextField.text = self.transaction.PartnerID;
                
                [alertView show];
                
            }
                break;
                
            default:
                break;
        }
    }
    

}

#pragma mark - AlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex == 1 && [alertView.title isEqualToString:@"PartnerID"]) {
        UITextField *tf = [alertView textFieldAtIndex:0];
        self.transaction.PartnerID = tf.text;
    }
    if (buttonIndex == 1 && [alertView.title isEqualToString:@"Options"]) {
        UITextField *tf = [alertView textFieldAtIndex:0];
        self.transaction.Options = [tf.text componentsSeparatedByString:@","];
    }
}

@end
