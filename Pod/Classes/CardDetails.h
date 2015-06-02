//
//  CardDetails.h
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardDetails : NSObject

@property (nonatomic, strong) NSString *Name; // Name on the card
@property (nonatomic, strong) NSString *Number; // Credit card number (16­21 digits)
@property (nonatomic, strong) NSString *ExpiryMonth; // 2 Digits
@property (nonatomic, strong) NSString *ExpiryYear; // 2 or 4 digits e.g. "15" or "2015"
@property (nonatomic, strong) NSString *StartMonth; // 2 digits (required in some countries)
@property (nonatomic, strong) NSString *StartYear; // 2 or 4 digits (required in some countries)
@property (nonatomic, strong) NSString *IssueNumber; // Card issue number (required in some countries)
@property (nonatomic, strong) NSString *CVN; // 3 or 4 digit number, required for transactions of type Purchase. Optional for other transaction types.

- (NSDictionary *)dictionary;

@end
