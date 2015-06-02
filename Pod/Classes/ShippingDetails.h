//
//  ShippingDetails.h
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enumerated.h"
#import "Address.h"

//Combines all the Shipping related information for a transaction

@interface ShippingDetails : NSObject

@property (nonatomic, strong) NSString *FirstName; //First name on the shipping manifest
@property (nonatomic, strong) NSString *LastName; //Last name on the shipping manifest
@property (nonatomic, assign) ShippingMethod ShippingMethod; //ShippingMethod enum.
@property (nonatomic, strong) Address *ShippingAddress; // Destination of the sale;
@property (nonatomic, strong) NSString *Email; //Email of the recipient
@property (nonatomic, strong) NSString *Phone; //Phone number of the recipient
@property (nonatomic, strong) NSString *Fax; //Fax number of the recipient

- (NSDictionary *)dictionary;

@end
