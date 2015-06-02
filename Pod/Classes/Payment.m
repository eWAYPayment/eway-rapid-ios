//
//  Payment.m
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "Payment.h"

@implementation Payment

- (NSDictionary *)dictionary
{
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:self.Payment],@"TotalAmount",
            self.InvoiceNumber,@"InvoiceNumber",
            self.InvoiceDescription,@"InvoiceDescription",
            self.InvoiceReference,@"InvoiceReference",
            self.CurrencyCode,@"CurrencyCode",
            nil];
}

@end
