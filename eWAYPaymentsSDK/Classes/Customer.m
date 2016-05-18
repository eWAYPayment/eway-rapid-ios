//
//  Customer.m
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "Customer.h"

@implementation Customer

- (id)init
{
    self = [super init];
    
    if ( self )
    {
        self.Reference = @"";
        self.Title = @"";
        self.FirstName = @"";
        self.LastName = @"";
        self.CompanyName = @"AUD";
        self.JobDescription = @"";
        self.Email = @"";
        self.Phone = @"";
        self.Mobile = @"";
        self.Comments = @"";
        self.Fax = @"";
        self.Url = @"";
        self.TokenCustomerID = @"";
        
        self.Address = [[Address alloc] init];
        self.Address.Street1 = @"";
        self.Address.Street2 = @"";
        self.Address.City = @"";
        self.Address.State = @"";
        self.Address.PostalCode = @"";
        self.Address.Country = @"";
        
        self.CardDetails = [[CardDetails alloc] init];
        self.CardDetails.Name = @"";
        self.CardDetails.Number = @"";
        self.CardDetails.ExpiryMonth = @"";
        self.CardDetails.ExpiryYear = @"";
        self.CardDetails.StartMonth = @"";
        self.CardDetails.StartYear = @"";
        self.CardDetails.CVN = @"";
    }
    
    return self;
}

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
            self.Email,@"Email",
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
