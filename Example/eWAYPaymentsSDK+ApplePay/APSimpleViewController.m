//
//  APSimpleViewController.m
//  eWAYPaymentsSDK+ApplePay
//
//  Created by lok on 16/11/2015.
//  Copyright © 2015 eWAY. All rights reserved.
//

#import "APSimpleViewController.h"
#import "RapidAPI+ApplePay.h"

@interface APSimpleViewController () <PKPaymentAuthorizationViewControllerDelegate>
{
    NSString *merchantIdentifier;
    NSString *countryCode;
    NSArray *supportedNetworks;
    PKMerchantCapability merchantCapabilities;
    NSArray *paymentSummaryItems;
    NSString *currencyCode;
    PKAddressField requiredBillingAddressFields;
    PKAddressField requiredShippingAddressFields;
    NSArray *shippingMethods;
    NSString *transactionID;
    IBOutlet UITextField *tfTransactionID;
    NSString *token;
    IBOutlet UITextField *tfToken;
    IBOutlet UILabel *lbResult;
    TransactionType transactionType;
    Method method;
}

@end

@implementation APSimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set this to your Apple Pay Merchant ID from Developer account
    merchantIdentifier = @"You Merchant ID from Developer account";
    
    countryCode = @"AU";
    
    //Indicate which payment networks you support by populating the supportedNetworks property with an array of string constants.
    supportedNetworks = @[PKPaymentNetworkAmex, PKPaymentNetworkMasterCard, PKPaymentNetworkVisa];
    
    //Indicate which payment processing protocols you support by setting a value for the merchantCapabilities property
    merchantCapabilities = PKMerchantCapability3DS;
    
    //Create an instance of PKShippingMethod for each available shipping method
    PKShippingMethod *standard =
    [PKShippingMethod summaryItemWithLabel:@"Standard Shipping" amount:[NSDecimalNumber decimalNumberWithString:@"0.05"]];
    standard.detail = @"5 Business Days";
    standard.identifier = @"standard";
    PKShippingMethod *express =
    [PKShippingMethod summaryItemWithLabel:@"Express Shipping" amount:[NSDecimalNumber decimalNumberWithString:@"0.10"]];
    express.detail = @"Next Day";
    express.identifier = @"next-day";
    
    shippingMethods = @[standard, express];
    
    //Payment summary items, represented by the PKPaymentSummaryItem class, describe the different parts of the payment request to the user.
    PKPaymentSummaryItem *firstItem = [PKPaymentSummaryItem summaryItemWithLabel:@"iPad" amount:[NSDecimalNumber decimalNumberWithString:@"3.00"]];
    PKPaymentSummaryItem *secondItem = [PKPaymentSummaryItem summaryItemWithLabel:@"iWatch" amount:[NSDecimalNumber decimalNumberWithString:@"1.00"]];
    PKPaymentSummaryItem *shippingItem = [PKPaymentSummaryItem summaryItemWithLabel:standard.identifier amount:standard.amount];
    
    //The last payment summary item in the list is the grand total. Calculate the grand total amount by adding the amounts of all the other summary items.
    NSDecimalNumber *total = [firstItem.amount decimalNumberByAdding:[secondItem.amount decimalNumberByAdding:shippingItem.amount]];
    PKPaymentSummaryItem *totalItem = [PKPaymentSummaryItem summaryItemWithLabel:@"Your Company Name" amount:total];
    
    paymentSummaryItems = @[firstItem, secondItem, shippingItem,totalItem];
    
    currencyCode = @"AUD";
    
    //Populate the requiredBillingAddressFields and requiredShippingAddressFields properties of the payment authorization view controller to indicate what billing and shipping information is needed
    requiredBillingAddressFields = PKAddressFieldPostalAddress | PKAddressFieldName;
    requiredShippingAddressFields = PKAddressFieldPostalAddress;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)Pay:(id)sender {
    
    transactionType = Purchase;
    method = ProcessPayment;
    
    //Create PKPaymentRequest
    [RapidAPI CreateApplePayRequest:merchantIdentifier countryCode:countryCode supportedNetworks:supportedNetworks merchantCapabilities:merchantCapabilities paymentSummaryItems:paymentSummaryItems currencyCode:currencyCode requiredBillingAddressFields:requiredBillingAddressFields billingAddress:nil requiredShippingAddressFields:requiredShippingAddressFields shippingAddress:nil shippingMethods:shippingMethods onCompletion:^(PKPaymentRequest *paymentRequest, NSError *error) {
        if (error) {
            NSLog(@"Error creating payment request: %@", [error localizedDescription]);
            
            UIAlertView *errorAlert = [[UIAlertView alloc]
                                       initWithTitle: @"Error"
                                       message: [error localizedDescription]
                                       delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
            [errorAlert show];
            return;
        }
        
        //Bring up the PKPaymentAuthorizationViewController, pass the payment request to the view controller’s initializer
        //Set a delegate for the view controller, and then present it.
        [RapidAPI ShowApplePayAuthorizationView:paymentRequest withDelegateController:self];
        
    }];
    
}

#pragma mark PaymentAuthorizationViewController Delegate Methods
- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
                  didSelectShippingAddress:(ABRecordRef)address
                                completion:(void (^)(PKPaymentAuthorizationStatus status, NSArray<PKShippingMethod *> *shippingMethods, NSArray<PKPaymentSummaryItem *>  *summaryItems))completion {
    
    completion(PKPaymentAuthorizationStatusSuccess,nil,nil);
    
}


- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
                   didSelectShippingMethod:(PKShippingMethod *)shippingMethod
                                completion:(void (^)(PKPaymentAuthorizationStatus, NSArray<PKPaymentSummaryItem *>  *summaryItems))completion {
    completion(PKPaymentAuthorizationStatusSuccess, [self summaryItemsForShippingMethod:shippingMethod]);
}

- (NSArray *)summaryItemsForShippingMethod:(PKShippingMethod *)shippingMethod {
    NSMutableArray *summaryItemsArray = [NSMutableArray new];
    
    [summaryItemsArray addObject:(PKPaymentSummaryItem *)paymentSummaryItems[0]];
    [summaryItemsArray addObject:(PKPaymentSummaryItem *)paymentSummaryItems[1]];
    
    PKPaymentSummaryItem *shippingItem = [PKPaymentSummaryItem summaryItemWithLabel:shippingMethod.identifier amount:shippingMethod.amount];
    NSDecimalNumber *total = [((PKPaymentSummaryItem *)paymentSummaryItems[0]).amount decimalNumberByAdding:[((PKPaymentSummaryItem *)paymentSummaryItems[1]).amount decimalNumberByAdding:shippingMethod.amount]];
    PKPaymentSummaryItem *totalItem = [PKPaymentSummaryItem summaryItemWithLabel:@"Your Company Name" amount:total];
    
    [summaryItemsArray addObject:shippingItem];
    [summaryItemsArray addObject:totalItem];
    
    return summaryItemsArray;
}

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
                       didAuthorizePayment:(PKPayment *)payment
                                completion:(void (^)(PKPaymentAuthorizationStatus))completion {
    
    
    [RapidAPI submitApplePay:payment transactionType:transactionType method:method completed:^(SubmitPaymentResponse *submitPaymentResponse) {
        NSString *msg = [NSString stringWithFormat:@"%@",@{@"Errors":submitPaymentResponse.Errors,@"SubmissionID":submitPaymentResponse.SubmissionID, @"Status":[NSString stringWithFormat:@"%lu",(unsigned long)submitPaymentResponse.Status]}];
        NSLog(@"Apple Pay Result %@", msg);
        if (submitPaymentResponse.Status != Error && [submitPaymentResponse.SubmissionID length] > 0)
            completion(PKPaymentAuthorizationStatusSuccess);
        else
            completion(PKPaymentAuthorizationStatusFailure);
        
    }];
}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
