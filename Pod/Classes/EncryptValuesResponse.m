//
//  EncryptValuesResponse.m
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "EncryptValuesResponse.h"

@implementation EncryptValuesResponse

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        self.Errors = [NSString stringWithFormat:@"%@", [dictionary objectForKey:@"Errors"]];
        if (!self.Errors || [self.Errors isEqualToString:@""] || [self.Errors isEqualToString:@"<null>"]) {
            self.Status = Success;
        }
        else
        {
            self.Status = Error;
        }
        
        
        NSMutableArray *arr = [NSMutableArray new];
        for (NSDictionary *dict in [dictionary objectForKey:@"Items"]) {
            NVpair *obj = [[NVpair alloc] initWithDictionary:dict];
            [arr addObject:obj];
        }
        
        self.Values = [[NSArray alloc] initWithArray:arr];
    }
    return self;
}


@end
