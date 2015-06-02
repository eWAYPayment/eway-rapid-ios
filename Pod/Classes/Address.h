//
//  Address.h
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Address : NSObject

@property (nonatomic, strong) NSString *Street1; //First line of the street address. e.g. "Unit 1"
@property (nonatomic, strong) NSString *Street2; //Second line of the street address. e.g. "6 Coonabmble st"
@property (nonatomic, strong) NSString *City; //City for the address, e.g. "Gulargambone"
@property (nonatomic, strong) NSString *State; // State or province code. e.g. 'NSW"
@property (nonatomic, strong) NSString *Country; //Country. e.g. "Australia"
@property (nonatomic, strong) NSString *PostalCode; //e.g. 2828

@end
