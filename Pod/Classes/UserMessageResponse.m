//
//  UserMessageResponse.m
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "UserMessageResponse.h"

@implementation UserMessageResponse

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary
{
    if (self = [super init])
    {
        @try {
            self.Errors = [NSString stringWithFormat:@"%@", [otherDictionary objectForKey:@"Errors"]];
            self.Messages = [otherDictionary objectForKey:@"CodeDetails"];
        }
        @catch (NSException *exception) {
            NSLog(@"Exception : %@",[exception description]);
        }
    }
    return self;
}

@end
