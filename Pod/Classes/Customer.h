//
//  Customer.h
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Address.h"
#import "CardDetails.h"

//Contains members that define a Rapid token customer (and card) stored in the Merchant's account.
@interface Customer : NSObject

@property (nonatomic, strong) NSString *TokenCustomerID; //Numeric ID identifying this customer
@property (nonatomic, strong) NSString *Reference; // Merchant's own reference ID for the customer
@property (nonatomic, strong) NSString *Title; // Mr. Mrs. etc min length 3 max len 5
@property (nonatomic, strong) NSString *FirstName; // Customer First Name
@property (nonatomic, strong) NSString *LastName; // Customer Last name
@property (nonatomic, strong) NSString *CompanyName; //Customer's company name
@property (nonatomic, strong) NSString *JobDescription; //role or job description
@property (nonatomic, strong) Address *Address; //Customer address
@property (nonatomic, strong) NSString *Phone; //Customer Phone
@property (nonatomic, strong) NSString *Mobile; // Customer Mobile Phone
@property (nonatomic, strong) NSString *Email; // Customer Email
@property (nonatomic, strong) NSString *Fax; //Customer Fax number
@property (nonatomic, strong) NSString *Url; // URL for customer's site
@property (nonatomic, strong) NSString *Comments; //Comments attached to this customer.
@property (nonatomic, strong) CardDetails *CardDetails; //The card details for this customer.

- (NSDictionary *)dictionary;

@end
