//
//  MyRapid.m
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

#import "RapidAPI.h"
#import "Reachability.h"


@implementation RapidAPI

+ (id)sharedManager {
    static RapidAPI *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

//detect connecting internet
- (BOOL)connectedToInternet
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

//validata url type
- (BOOL) validateUrl:(NSString *) candidate {
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return ![urlTest evaluateWithObject:candidate];
}


//init response object for internal error
- (id)errorObjectWithErrorCode:(NSString *)errorCode ressponseType:(ResponseType)type
{
    id object;
    switch (type) {
        case EncryptValuesResponseType:
            object = [[EncryptValuesResponse alloc] init];
            ((EncryptValuesResponse*)object).Status = Error;
            ((EncryptValuesResponse*)object).Errors = errorCode;
            return object;
            
            break;
        case SubmitPaymentResponseType:
            object = [[SubmitPaymentResponse alloc] init];
            ((SubmitPaymentResponse*)object).Status = Error;
            ((SubmitPaymentResponse*)object).SubmissionID = @"";
            ((SubmitPaymentResponse*)object).Errors = errorCode;
            return object;
            break;
        case UserMessageResponseType:
            object = [[UserMessageResponse alloc] init];
            ((UserMessageResponse*)object).Errors = errorCode;
            return object;
            break;
            
        default:
            
            break;
    }
    return object;
}

//validate internal network
- (id)validateWithRessponseType:(ResponseType)type
{
    id object;
    
    if (![self connectedToInternet]) {
        
        return [self errorObjectWithErrorCode:@"S9992" ressponseType:type];
    }
    else if ([self.PublicAPIKey isEqualToString:@""]) {
        return [self errorObjectWithErrorCode:@"S9991" ressponseType:type];
    }
    else if ([self.RapidEndpoint isEqualToString:@""]) {
        return [self errorObjectWithErrorCode:@"S9990" ressponseType:type];
    }
    else if ([self validateUrl:self.RapidEndpoint])
    {
        return [self errorObjectWithErrorCode:@"S9992" ressponseType:type];
    }
    else if (![[self.RapidEndpoint substringFromIndex:self.RapidEndpoint.length - 1] isEqualToString:@"/"])
    {
        return [self errorObjectWithErrorCode:@"S9990" ressponseType:type];
    }
    else return nil;
    
    return object;
}

#pragma mark - encryptValues
+ (void)encryptValues:(NSArray *)Values completed:(void (^)(EncryptValuesResponse *encryptValuesResponse))completed
{
    [[RapidAPI sharedManager] encryptValues:Values completed:completed];
}

- (void)encryptValues:(NSArray *)Values completed:(void (^)(EncryptValuesResponse *encryptValuesResponse))completed
{
    //Internal system error
    id object = [self validateWithRessponseType:EncryptValuesResponseType];
    if (object ) {
        completed(object);
        return;
    }
    
    
    //create json object
    NSMutableDictionary *paramObject = [NSMutableDictionary new];
    @try {
        //generate list item to dictionary
        NSMutableArray *arr = [NSMutableArray new];
        for (NVpair *obj in Values) {
            [arr addObject:[obj dictionary]];
        }
        
        
        [paramObject setObject:@"eCrypt" forKey:@"Method"];
        [paramObject setObject:arr forKey:@"Items"];
    }
    @catch (NSException *exception) {
        //exception: maybe internal SDK, params Bad vv
        EncryptValuesResponse *encryptValuesResponse = [[EncryptValuesResponse alloc] init];
        encryptValuesResponse.Status = Error;
        encryptValuesResponse.Errors = @"S9995";
        completed(encryptValuesResponse);
        return;
    }
    
    
    //change json object to json string
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramObject options:NSJSONWritingPrettyPrinted error:&writeError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //NSLog(@"JSON Output: %@", jsonString);
    
    //request api encrypt
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", self.PublicAPIKey, @""];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
    NSString* userAgent = @"Mozilla/6.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/8.0 Mobile/10A5376e Safari/8536.25;eWAY SDK iOS 1.1";
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@encrypt",self.RapidEndpoint]]];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        EncryptValuesResponse *encryptValuesResponse;
        
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            
            if (statusCode == 443) {
                encryptValuesResponse = [self errorObjectWithErrorCode:@"S9991" ressponseType:EncryptValuesResponseType];
                completed(encryptValuesResponse);
                return;
            }
        }
        
        if (error) {
            encryptValuesResponse = [self errorObjectWithErrorCode:@"S9994" ressponseType:EncryptValuesResponseType];
        }
        else
        {
            //need to proce data to object when before return object via block
            NSError *errorEncode = nil;
            NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errorEncode];
            encryptValuesResponse = [[EncryptValuesResponse alloc] initWithDictionary:responseObject];
        }
        completed(encryptValuesResponse);
        
    }] resume];
}

#pragma mark - Submit Payment
+ (void)submitPayment:(Transaction *)Transaction completed:(void (^)(SubmitPaymentResponse *submitPaymentResponse))completed
{
    [[RapidAPI sharedManager] submitPayment:Transaction completed:completed];
}

- (void)submitPayment:(Transaction *)Transaction completed:(void (^)(SubmitPaymentResponse *submitPaymentResponse))completed
{
    //Internal system error
    id object = [self validateWithRessponseType:SubmitPaymentResponseType];
    if (object ) {
        completed(object);
        return;
    }
    
    
    //create json object
    NSMutableDictionary *paramObject = [NSMutableDictionary new];
    @try {
        paramObject = [[NSMutableDictionary alloc] initWithDictionary:[Transaction dictionary]];
    }
    @catch (NSException *exception) {
        //exception: maybe internal SDK, params Bad vv
        SubmitPaymentResponse *submitPaymentResponse = [[SubmitPaymentResponse alloc] init];
        submitPaymentResponse.Status = Error;
        submitPaymentResponse.Errors = @"S9995";
        completed(submitPaymentResponse);
        return;
    }
    
    
    //change json object to json string
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramObject options:NSJSONWritingPrettyPrinted error:&writeError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    // NSLog(@"JSON Output: %@", jsonString);
    
    //request api encrypt
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", self.PublicAPIKey, @""];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
    NSString* userAgent = @"Mozilla/6.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/8.0 Mobile/10A5376e Safari/8536.25;eWAY SDK iOS 1.1";
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Payment",self.RapidEndpoint]]];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"POST"];
    [request setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        SubmitPaymentResponse *submitPaymentResponse;
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            
            if (statusCode == 443) {
                submitPaymentResponse = [self errorObjectWithErrorCode:@"S9991" ressponseType:SubmitPaymentResponseType];
                completed(submitPaymentResponse);
                return;
            }
        }
        
        
        
        if (error) {
            submitPaymentResponse = [self errorObjectWithErrorCode:@"S9994" ressponseType:SubmitPaymentResponseType];
        }
        else
        {
            //need to proce data to object when before return object via block
            NSError *errorEncode = nil;
            NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errorEncode];
            submitPaymentResponse = [[SubmitPaymentResponse alloc] initWithDictionary:responseObject];
        }
        completed(submitPaymentResponse);
        
    }] resume];
}

#pragma mark - userMessage
+ (void)userMessage:(NSString *)ErrorCodes Language:(NSString *)Language completed:(void (^)(UserMessageResponse *userMessageResponse))completed
{
    [[RapidAPI sharedManager] userMessage:ErrorCodes Language:Language completed:completed];
}


- (void)userMessage:(NSString *)ErrorCodes Language:(NSString *)Language completed:(void (^)(UserMessageResponse *userMessageResponse))completed
{
    //Internal system error
    id object = [self validateWithRessponseType:UserMessageResponseType];
    if (object ) {
        completed(object);
        return;
    }
    
    
    //create json object
    NSMutableDictionary *paramObject = [NSMutableDictionary new];
    @try {
        NSArray *arr = [ErrorCodes componentsSeparatedByString:@","];
        
        
        [paramObject setObject:arr forKey:@"ErrorCodes"];
        [paramObject setObject:Language forKey:@"Language"];
    }
    @catch (NSException *exception) {
        //exception: maybe internal SDK, params Bad vv
        UserMessageResponse *userMessageResponse = [[UserMessageResponse alloc] init];
        userMessageResponse.Errors = @"S9995";
        completed(userMessageResponse);
        return;
    }
    
    //change json object to json string
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramObject options:NSJSONWritingPrettyPrinted error:&writeError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    NSLog(@"JSON Output: %@", jsonString);
    
    //request api encrypt
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", self.PublicAPIKey, @""];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
    NSString* userAgent = @"Mozilla/6.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/8.0 Mobile/10A5376e Safari/8536.25;eWAY SDK iOS 1.1";
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@CodeLookup",self.RapidEndpoint]]];
    
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        UserMessageResponse *userMessageResponse;
        
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            
            if (statusCode == 443) {
                userMessageResponse = [self errorObjectWithErrorCode:@"S9991" ressponseType:UserMessageResponseType];
                completed(userMessageResponse);
                return;
            }
        }
        
        if (error) {
            userMessageResponse = [self errorObjectWithErrorCode:@"S9994" ressponseType:UserMessageResponseType];
        }
        else
        {
            //need to proce data to object when before return object via block
            NSError *errorEncode = nil;
            NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errorEncode];
            userMessageResponse = [[UserMessageResponse alloc] initWithDictionary:responseObject];
        }
        completed(userMessageResponse);
        
    }] resume];
}

@end
