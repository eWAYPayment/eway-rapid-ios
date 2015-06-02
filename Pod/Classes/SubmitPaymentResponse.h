//
//  SubmitPaymentResponse.h
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enumerated.h"


//This is used to return the results of the payment submission to the app developer.
@interface SubmitPaymentResponse : NSObject

@property (nonatomic , strong) NSString *Errors; //Comma separated list of error codes, if any.
@property (nonatomic , strong) NSString *SubmissionID; //SubmissionID (Actually the Access code for the transaction). Can be displayed to the end user and/or used server side to query transaction results.
@property (nonatomic , assign) Status Status; //Enum indicating whether an error occurred or whether the payment was accepted.

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary;

@end
