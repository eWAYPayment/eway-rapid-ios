//
//  NVpair.m
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "NVpair.h"

@implementation NVpair

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        self.name = [NSString stringWithFormat:@"%@", [dictionary objectForKey:@"Name"]];
        self.value = [NSString stringWithFormat:@"%@", [dictionary objectForKey:@"Value"]];
    }
    return self;
}

- (NSDictionary *)dictionary
{
    return [NSDictionary dictionaryWithObjectsAndKeys:self.name,@"name",self.value,@"value", nil];
}

@end
