//
//  EncryptValuesResponse.h
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVpair.h"
#import "Enumerated.h"

//This is used to return the encrypted value to the caller along with any errors that may have occurred as a result of the method call.
//In the event that an error occurs, the Values property will be empty, this is intentional so that app code that fails to check for errors do not inadvertently pass unencrypted values to external systems.
@interface EncryptValuesResponse : NSObject

@property (nonatomic, strong) NSString *Errors;  //Comma separated list of error codes, if any.
@property (nonatomic, strong) NSArray *Values; //Array of NVPair objects the same size as passed into the method, but with the values encrypted.
@property (nonatomic, assign) Status Status; //Enum indicate if the call was successfull or not.

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
