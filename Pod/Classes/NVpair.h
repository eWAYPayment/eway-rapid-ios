//
//  NVpair.h
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <Foundation/Foundation.h>

//This is used primarily as a container for a name­value pair to be consumed and returned by the encryption method requests and responses.
@interface NVpair : NSObject

@property (nonatomic, strong) NSString *name; //Name of the value
@property (nonatomic, strong) NSString *value; //Value.


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
//generate object to nsdictionary
- (NSDictionary *)dictionary;

@end
