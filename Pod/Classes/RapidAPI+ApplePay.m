//
//  RapidAPI+ApplePay.m
//  Pods
//
//  Created by lok on 30/07/2015.
//
//

#import "RapidAPI+ApplePay.h"
#import <AddressBook/AddressBook.h>

@implementation RapidAPI (ApplePay)

+ (void)CreateApplePayRequest:(NSString *)merchantIdentifier
                  countryCode:(NSString *)countryCode
            supportedNetworks:(NSArray *)supportedNetworks
         merchantCapabilities:(PKMerchantCapability)merchantCapabilities
          paymentSummaryItems:(NSArray *)paymentSummaryItems
                 currencyCode:(NSString *)currencyCode
 requiredBillingAddressFields:(PKAddressField)requiredBillingAddressFields
               billingAddress:(ABRecordRef *)billingAddress
requiredShippingAddressFields:(PKAddressField)requiredShippingAddressFields
              shippingAddress:(ABRecordRef *)shippingAddress
              shippingMethods:(NSArray *)shippingMethods
                 onCompletion:(void (^) (PKPaymentRequest *paymentRequest, NSError *error))onCompletion
{
    PKPaymentRequest *paymentRequest = [PKPaymentRequest new];
    
    //TODO: Add validation Errors
    
        [paymentRequest setMerchantIdentifier:merchantIdentifier];

    
    [paymentRequest setCountryCode:countryCode];
    

        [paymentRequest setSupportedNetworks:supportedNetworks];

    
    [paymentRequest setMerchantCapabilities:merchantCapabilities];
    [paymentRequest setPaymentSummaryItems:paymentSummaryItems];
    [paymentRequest setCurrencyCode:currencyCode];
    [paymentRequest setRequiredBillingAddressFields:requiredBillingAddressFields];
    [paymentRequest setBillingAddress:billingAddress];
    [paymentRequest setRequiredShippingAddressFields:requiredShippingAddressFields];
    [paymentRequest setShippingAddress:shippingAddress];
    [paymentRequest setShippingMethods:shippingMethods];
    
    // Check allow payment networks
    // YES if the user can authorize payments on this device using one of the payment networks supported
    // by the merchant.
    // NO if the user cannot authorize payments on these networks or if the user is restricted from
    // authorizing payments.
    if (![PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:supportedNetworks]) {
        NSError *error = [NSError errorWithDomain:@"RapidApplePay" code:05 userInfo:@{NSLocalizedDescriptionKey: @"payment networks not allowed"}];
        onCompletion(paymentRequest, error);
    }
    else
        onCompletion(paymentRequest, nil);
    
}

+ (void)ShowApplePayAuthorizationView:(PKPaymentRequest *)paymentRequest withDelegateController:(UIViewController *)withDelegateController
{
    PKPaymentAuthorizationViewController *auth = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:paymentRequest];
    auth.delegate = (id)withDelegateController;
    [withDelegateController presentViewController:auth animated:YES completion:nil];
}

#pragma mark - Submit Payment
+ (void)submitApplePay:(PKPayment *)payment transactionType:(TransactionType)transactionType method:(Method)method completed:(void (^)(SubmitPaymentResponse *submitPaymentResponse))completed
{
    [[RapidAPI sharedManager] submitApplePay:payment transactionType:transactionType method:method completed:completed];
}

- (void)submitApplePay:(PKPayment *)payment transactionType:(TransactionType)transactionType method:(Method)method completed:(void (^)(SubmitPaymentResponse *submitPaymentResponse))completed
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
        Transaction *tran = [[Transaction alloc] init];
        
        tran.TransactionType = transactionType;
        tran.Method = method;
        
        if (payment.shippingAddress) {
            
            
            Customer *customerObj = [[Customer alloc] init];
            customerObj.FirstName = (__bridge_transfer NSString*)ABRecordCopyValue(payment.shippingAddress, kABPersonFirstNameProperty);
            customerObj.LastName = (__bridge_transfer NSString*)ABRecordCopyValue(payment.shippingAddress, kABPersonLastNameProperty);
            
            //customerObj.CompanyName = @"";
            //customerObj.Phone = @"09 889 0986";
            //customerObj.Mobile = @"09 889 0986";
            
            Address *address = [[Address alloc] init];
            
            ABMultiValueRef addressValues = ABRecordCopyValue(payment.shippingAddress, kABPersonAddressProperty);
            if (addressValues != NULL) {
                if (ABMultiValueGetCount(addressValues) > 0) {
                    CFDictionaryRef dict = ABMultiValueCopyValueAtIndex(addressValues, 0);
                    NSString *street = CFDictionaryGetValue(dict, kABPersonAddressStreetKey);
                    if (street) {
                        address.Street1 = street;
                    }
                    NSString *city = CFDictionaryGetValue(dict, kABPersonAddressCityKey);
                    if (city) {
                        address.City = city;
                    }
                    NSString *state = CFDictionaryGetValue(dict, kABPersonAddressStateKey);
                    if (state) {
                        address.State = state;
                    }
                    NSString *postalCode = CFDictionaryGetValue(dict, kABPersonAddressZIPKey);
                    if (postalCode) {
                        address.PostalCode = postalCode;
                    }
                    NSString *country = CFDictionaryGetValue(dict, kABPersonAddressCountryKey);
                    if (country) {
                        //Need a method to convert country to country code
                        address.Country = @"AU";
                    }
                    CFRelease(dict);
                }
                CFRelease(addressValues);
            }
            customerObj.Address = address;
            
            ShippingDetails *shipping = [[ShippingDetails alloc] init];
            shipping.FirstName = (__bridge_transfer NSString*)ABRecordCopyValue(payment.shippingAddress, kABPersonFirstNameProperty);
            shipping.LastName = (__bridge_transfer NSString*)ABRecordCopyValue(payment.shippingAddress, kABPersonLastNameProperty);
            shipping.ShippingAddress = address;
            
            tran.Customer = customerObj;
            tran.ShippingDetails = shipping;
        }
        
        
        NSDictionary *paymentData = [NSJSONSerialization JSONObjectWithData:payment.token.paymentData options:NSJSONReadingAllowFragments error:nil];
        
        
        NSMutableDictionary *applePayObject = [NSMutableDictionary new];
        
        [applePayObject setObject:[paymentData objectForKey:@"data"] forKey:@"data"];
        
        [applePayObject setObject:[paymentData objectForKey:@"header"] forKey:@"header"];
        
        [applePayObject setObject:[paymentData objectForKey:@"signature"] forKey:@"signature"];
        
        [applePayObject setObject:[paymentData objectForKey:@"version"] forKey:@"version"];
        
        
        if (payment.token.paymentInstrumentName)
            [applePayObject setObject:payment.token.paymentInstrumentName forKey:@"PaymentInstrumentName"];
        
        if (payment.token.paymentNetwork)
            [applePayObject setObject:payment.token.paymentNetwork forKey:@"PaymentNetwork"];
        
        if (payment.token.transactionIdentifier)
            [applePayObject setObject:payment.token.transactionIdentifier forKey:@"TransactionIdentifier"];
        
        
        paramObject = [[NSMutableDictionary alloc] initWithDictionary:[tran dictionary]];
        
        [paramObject setObject:applePayObject forKey:@"ApplePay"];
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
    //    NSLog(@"JSON Output: %@", jsonString);
    
    //request api encrypt
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", self.PublicAPIKey, @""];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
    //NSString* userAgent = @"Mozilla/6.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/8.0 Mobile/10A5376e Safari/8536.25;eWAY SDK iOS 1.1";
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Payment",self.RapidEndpoint]]];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"POST"];
    //[request setValue:userAgent forHTTPHeaderField:@"User-Agent"];
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
            NSString *rawStr = [NSString stringWithUTF8String:[data bytes]];
            NSLog(@"RawResponse from Payment endpoint %@",rawStr);
            NSLog(@"data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errorEncode];
            submitPaymentResponse = [[SubmitPaymentResponse alloc] initWithDictionary:responseObject];
        }
        completed(submitPaymentResponse);
        
    }] resume];
}


@end
