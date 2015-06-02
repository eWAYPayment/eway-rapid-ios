//
//  Customer.m
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "Customer.h"

@implementation Customer

- (NSDictionary *)dictionary
{
    return [NSDictionary dictionaryWithObjectsAndKeys:self.Reference,@"Reference",
            self.Title,@"Title",
            self.FirstName,@"FirstName",
            self.LastName,@"LastName",
            self.CompanyName,@"CompanyName",
            self.JobDescription,@"JobDescription",
            self.Address.Street1,@"Street1",
            self.Address.Street2,@"Street2",
            self.Address.City,@"City",
            self.Address.State,@"State",
            self.Address.PostalCode,@"PostalCode",
            self.Address.Country,@"Country",
            @"",@"Email",
            self.Phone,@"Phone",
            self.Mobile,@"Mobile",
            self.Comments,@"Comments",
            self.Fax,@"Fax",
            self.Url,@"Url",
            [self.CardDetails dictionary],@"CardDetails",
            self.TokenCustomerID,@"TokenCustomerID",
            nil];;
}

@end
