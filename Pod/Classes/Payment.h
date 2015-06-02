//
//  Payment.h
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Payment : NSObject

@property (nonatomic, assign) int Payment;//The total amount to charge the card holder in this transaction in cents. e.g. 1000 = $10.00
@property (nonatomic, strong) NSString *InvoiceNumber; //The merchant's invoice number
@property (nonatomic, strong) NSString *InvoiceDescription; // merchants invoice description
@property (nonatomic, strong) NSString *InvoiceReference; // The merchant's invoice reference
@property (nonatomic, strong) NSString *CurrencyCode; // The merchant's currency (e.g. AUD)

- (NSDictionary *)dictionary;

@end
