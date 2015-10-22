//
//  CardDetails.m
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "CardDetails.h"

@implementation CardDetails

-(id)init{
    self = [super init];
    
    if ( self )
    {
        self.Name = @"";
        self.Number = @"";
        self.ExpiryMonth = @"";
        self.ExpiryYear = @"";
        self.StartMonth = @"";
        self.StartYear = @"";
        self.CVN = @"";
    }
    
    return self;
}

- (NSDictionary *)dictionary
{
    return [NSDictionary dictionaryWithObjectsAndKeys:self.Name,@"Name",
            self.Number,@"Number",
            self.ExpiryMonth,@"ExpiryMonth",
            self.ExpiryYear,@"ExpiryYear",
            self.StartMonth,@"StartMonth",
            self.StartYear,@"StartYear",
            self.CVN,@"CVN",nil];;
}

@end
