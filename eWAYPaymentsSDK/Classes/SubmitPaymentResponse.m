//
//  SubmitPaymentResponse.m
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "SubmitPaymentResponse.h"

@implementation SubmitPaymentResponse

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary
{
    
    if (self = [super init])
    {
        self.Errors = [NSString stringWithFormat:@"%@", [otherDictionary objectForKey:@"Errors"]];
        if (!self.Errors || [self.Errors isEqualToString:@""] || [self.Errors isEqualToString:@"<null>"]) {
            self.Status = Accepted;
        }
        else
        {
            self.Status = Error;
        }
        
        
        self.SubmissionID = [NSString stringWithFormat:@"%@", [otherDictionary objectForKey:@"AccessCode"]];
    }
    return self;
}

@end
