//
//  Transaction.m
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "Transaction.h"
#import "LineItem.h"
#import <UIKit/UIKit.h>

@implementation Transaction


- (NSString *)getShippingMethod
{
    NSString *res = @"";
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"Unknown",[NSNumber numberWithInteger:Unknown],
                          @"LowCost",[NSNumber numberWithInteger:LowCost],
                          @"DesignatedByCustomer",[NSNumber numberWithInteger:DesignatedByCustomer],
                          @"International",[NSNumber numberWithInteger:International],
                          @"Military",[NSNumber numberWithInteger:Military],
                          @"NextDay",[NSNumber numberWithInteger:NextDay],
                          @"StorePickup",[NSNumber numberWithInteger:StorePickup],
                          @"TwoDayService",[NSNumber numberWithInteger:TwoDayService],
                          @"ThreeDayService",[NSNumber numberWithInteger:ThreeDayService],
                          @"Other",[NSNumber numberWithInteger:Other],
                          nil];
    res = [dict objectForKey:[NSNumber numberWithInteger:self.ShippingDetails.ShippingMethod]];
    return res;
}

- (NSString *)getTransactionType
{
    NSString *res = @"";
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"Purchase",[NSNumber numberWithInteger:Purchase],
                          @"Recurring",[NSNumber numberWithInteger:Recurring],
                          @"MOTO",[NSNumber numberWithInteger:MOTO],
                          nil];
    res = [dict objectForKey:[NSNumber numberWithInteger:self.TransactionType]];
    return res;
}

- (NSString *)getMethod
{
    NSString *res = @"";
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"ProcessPayment",[NSNumber numberWithInteger:ProcessPayment],
                          @"CreateTokenCustomer",[NSNumber numberWithInteger:CreateTokenCustomer],
                          @"TokenPayment",[NSNumber numberWithInteger:TokenPayment],
                          @"Authorise",[NSNumber numberWithInteger:Authorise],
                          nil];
    res = [dict objectForKey:[NSNumber numberWithInteger:self.Method]];
    return res;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    [dict setObject:[self.Customer dictionary] forKey:@"Customer"];
    
    if (self.ShippingDetails)
        [dict setObject:[self.ShippingDetails dictionary] forKey:@"ShippingAddress"];

    
    [dict setObject:[self getShippingMethod] forKey:@"ShippingMethod"];
    
    NSMutableArray *arrItems = [NSMutableArray new];
    for (LineItem *LineObj in self.LineItems) {
        [arrItems addObject:[LineObj dictionary]];
    }
    
    [dict setObject:arrItems forKey:@"Items"];
    
    if (self.Options)
        [dict setObject:self.Options forKey:@"Options"];
    
    if (self.Payment)
        [dict setObject:[self.Payment dictionary] forKey:@"Payment"];
    
    NSString *deviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [dict setObject:deviceID forKey:@"DeviceID"];
    [dict setObject:@"" forKey:@"CustomerIP"];
    if (self.PartnerID)
        [dict setObject:self.PartnerID forKey:@"PartnerID"];
    [dict setObject:[self getTransactionType] forKey:@"TransactionType"];
    
    [dict setObject:[self getMethod] forKey:@"Method"];
    
    return dict;
}

@end
