//
//  RapidAPI+ApplePay.h
//  Pods
//
//  Created by lok on 30/07/2015.
//
//

#import <Foundation/Foundation.h>
#import "RapidAPI.h"
#import <PassKit/PassKit.h>

@interface RapidAPI (ApplePay)

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
                 onCompletion:(void (^) (PKPaymentRequest *paymentRequest, NSError *error))onCompletion;

+ (void)ShowApplePayAuthorizationView:(PKPaymentRequest *)paymentRequest
withDelegateController:(UIViewController *)withDelegateController;

+ (void)submitApplePay:(PKPayment *)payment transactionType:(TransactionType)transactionType method:(Method)method completed:(void (^)(SubmitPaymentResponse *submitPaymentResponse))completed;

@end
