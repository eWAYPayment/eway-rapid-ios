//
//  ShippingDetails.m
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "ShippingDetails.h"

@implementation ShippingDetails

- (NSDictionary *)dictionary
{
    return [NSDictionary dictionaryWithObjectsAndKeys:self.FirstName,@"FirstName",
            self.LastName,@"LastName",
            self.ShippingAddress.Street1,@"Street1",
            self.ShippingAddress.Street2,@"Street2",
            self.ShippingAddress.City,@"City",
            self.ShippingAddress.State,@"State",
            self.ShippingAddress.Country,@"Country",
            self.Phone,@"Phone",
            nil];;
}

@end
