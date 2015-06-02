//
//  UserMessageResponse.h
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <Foundation/Foundation.h>

//This is used to return the translated error codes to the caller along with any errors that may have occurred as a result of the method call.
//In the event that an error occurs, the Messages property will be empty.

@interface UserMessageResponse : NSObject

@property (nonatomic, strong) NSString *Errors; //Comma separated list of error codes, if any.
@property (nonatomic, strong) NSArray *Messages; //Array of messages, one for each of the comma separated codes passed into the method and in the same order.

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary;

@end
