//
//  Address.m
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "Address.h"

@implementation Address

-(id)init{
    self = [super init];
    
    if ( self )
    {
        self.Street1 = @"";
        self.Street2 = @"";
        self.City = @"";
        self.State = @"";
        self.PostalCode = @"";
        self.Country = @"";
    }
    
    return self;
}

@end
