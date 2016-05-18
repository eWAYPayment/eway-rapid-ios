//
//  LineItem.m
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "LineItem.h"

@implementation LineItem

- (NSDictionary *)dictionary
{
    return [NSDictionary dictionaryWithObjectsAndKeys:self.SKU,@"SKU",
            self.Description,@"Description",
            [NSNumber numberWithInt:self.Quantity],@"Quantity",
            [NSNumber numberWithInt:self.UnitCost],@"UnitCost",
            [NSNumber numberWithInt:self.Tax],@"Tax",
            [NSNumber numberWithInt:self.Total],@"Total",
            nil];
}


@end
