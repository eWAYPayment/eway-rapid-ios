//
//  LineItem.h
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LineItem : NSObject

@property (nonatomic, strong) NSString *SKU; // ID of the Line Item's product
@property (nonatomic, strong) NSString *Description; // Product description of the item
@property (nonatomic, assign) int Quantity; // The number of items
@property (nonatomic, assign) int UnitCost; // Price (in cents) of each item
@property (nonatomic, assign) int Tax; // Combined tax (in cents) for all the items
@property (nonatomic, assign) int Total; // Total (including Tax) for all the items.

- (NSDictionary *)dictionary;

@end
