//
//  Enumerated.h
//  Rapid
//
//  Created by eWAY on 4/13/15.
//  Copyright (c) 2015 eWAY. All rights reserved.
//

typedef enum : NSUInteger {
    Error, // An error occurred with the API Call.
    Success, // The API Call completed successfully.
    Accepted, // Only used for submitPayment API .The payment has been accepted for processing. This does not mean payment will necessarily be taken. Rapd API needs to be called using the submission ID to determine the actual result.
} Status;


typedef enum : NSUInteger {
    Purchase, // Used for a single purchase where the card is present. This will require that the CVN details are supplied.
    Recurring, // Used for a recurring transaction where the card details have been stored. This transaction type should be used when charging with a Token Customer
    MOTO, // Mail order or Telephone Transaction. Used when the card is not at hand. Can also be used when charging a Token customer.
} TransactionType;

typedef enum : NSUInteger {
    Unknown, //Method is unknown.
    LowCost, //A low cost method is used
    DesignatedByCustomer, //The customer has chosen the method
    International, //Item will be shipped international
    Military,
    NextDay,
    StorePickup,
    TwoDayService,
    ThreeDayService,
    Other,
} ShippingMethod;

typedef enum : NSUInteger {
    S9990, //Library does not have Endpoint initialised, or not initialise to a URL
    S9991, // Library does not have PublicAPI key initialised, or Key is Invalid.
    S9992, // Communication error with Rapid API.
    S9993, //Authentication error with Rapid API.
    S9994, // Internal system error communicating with Rapid API.
    S9995, //Internal SDK Error, Bad Parameters etc.
} ErrorCodes;