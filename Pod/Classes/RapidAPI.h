//
//  MyRapid.h
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVpair.h"
#import "EncryptValuesResponse.h"
#import "Transaction.h"
#import "SubmitPaymentResponse.h"
#import "UserMessageResponse.h"

typedef enum : NSUInteger {
    EncryptValuesResponseType = 0,
    SubmitPaymentResponseType = 1,
    UserMessageResponseType = 2,
} ResponseType;

@interface RapidAPI : NSObject

@property (nonatomic, strong) NSString *RapidEndpoint; //Sets the endpoint to "Production" "Sandbox" or a specific URL.
@property (nonatomic, strong) NSString *PublicAPIKey; //Sets the Merchant's Public API Key

+ (id)sharedManager;

+ (void)encryptValues:(NSArray *)Values completed:(void (^)(EncryptValuesResponse *encryptValuesResponse))completed;
+ (void)submitPayment:(Transaction *)Transaction completed:(void (^)(SubmitPaymentResponse *submitPaymentResponse))completed;
+ (void)userMessage:(NSString *)ErrorCodes Language:(NSString *)Language completed:(void (^)(UserMessageResponse *userMessageResponse))completed;

- (id)validateWithRessponseType:(ResponseType)type;
- (id)errorObjectWithErrorCode:(NSString *)errorCode ressponseType:(ResponseType)type;

@end
