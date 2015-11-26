//
//  Transaction.h
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enumerated.h"
#import "Customer.h"
#import "ShippingDetails.h"
#import "Payment.h"

//The details of the payment
@interface Transaction : NSObject

@property (nonatomic,assign) TransactionType TransactionType; //What type of transaction this is (Purchase, MOTO,etc)
@property (nonatomic,assign) Method Method; //which determines the action being taken with the request. (ProcessPayment, Authorise, TokenPayment etc)
@property (nonatomic,strong) Customer *Customer; //Customer details (name address token etc)
@property (nonatomic,strong) ShippingDetails *ShippingDetails; //(optional) Shipping Address, name etc for the product ordered with this transaction
@property (nonatomic,strong) Payment *Payment; //Payment details (amount, currency and invoice information)
@property (nonatomic,strong) NSArray *LineItems; //(optional) Invoice Line Items for the purchase
@property (nonatomic,strong) NSArray *Options; //(optional) General Options for the transaction
@property (nonatomic,strong) NSString *PartnerID; //(optional) Used by shopping carts/ partners.

- (NSDictionary *)dictionary;

@end
