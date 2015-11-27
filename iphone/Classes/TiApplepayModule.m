/**
 * ti.applepay
 *
 * Created by Your Name
 * Copyright (c) 2015 Your Company. All rights reserved.
 */

#import "TiApplepayModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiApplepayPaymentRequestProxy.h"
#import <PassKit/PassKit.h>

@implementation TiApplepayModule

#pragma mark Internal

-(id)moduleGUID
{
	return @"50220394-a69d-4820-b11c-7de647935809";
}

-(NSString*)moduleId
{
	return @"ti.applepay";
}

#pragma mark Lifecycle

-(void)startup
{
	[super startup];

	NSLog(@"[INFO] %@ loaded",self);
}

#pragma mark Public APIs

-(NSNumber*)isSupported:(id)unused
{
    return NUMBOOL([TiUtils isIOS9OrGreater] == YES);
}

-(NSNumber*)canMakePayments:(id)args
{
    NSArray *networks = nil;
    PKMerchantCapability capabilities;
    
    if ([args valueForKey:@"networks"]) {
        ENSURE_TYPE([args valueForKey:@"networks"], NSArray);
        networks = [args valueForKey:@"networks"];
        
        // Capabilities can only be checked together with networks
        if ([args valueForKey:@"capabilities"]) {
            ENSURE_TYPE([args valueForKey:@"capabilities"], NSArray);
            capabilities = [args valueForKey:@"capabilities"];
        }
    }
    
    if (networks != nil && capabilities) {
        return  NUMBOOL([PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:networks capabilities:capabilities]);
    } else if (networks != nil && !capabilities) {
        return NUMBOOL([PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:networks]);
    }
    
    return NUMBOOL([PKPaymentAuthorizationViewController canMakePayments]);
}

#pragma mark Public constants

MAKE_SYSTEM_PROP(PAYMENT_BUTTON_TYPE_PLAIN, PKPaymentButtonTypePlain);
MAKE_SYSTEM_PROP(PAYMENT_BUTTON_TYPE_BUY, PKPaymentButtonTypeBuy);
MAKE_SYSTEM_PROP(PAYMENT_BUTTON_TYPE_SETUP, PKPaymentButtonTypeSetUp);

MAKE_SYSTEM_PROP(PAYMENT_BUTTON_STYLE_BLACK, PKPaymentButtonStyleBlack);
MAKE_SYSTEM_PROP(PAYMENT_BUTTON_STYLE_WHITE, PKPaymentButtonStyleWhite);
MAKE_SYSTEM_PROP(PAYMENT_BUTTON_STYLE_WHITE_OUTLINE, PKPaymentButtonStyleWhiteOutline);

MAKE_SYSTEM_PROP(PAYMENT_METHOD_TYPE_CREDIT, PKPaymentMethodTypeCredit);
MAKE_SYSTEM_PROP(PAYMENT_METHOD_TYPE_DEBIT, PKPaymentMethodTypeDebit);
MAKE_SYSTEM_PROP(PAYMENT_METHOD_TYPE_PREPAID, PKPaymentMethodTypePrepaid);
MAKE_SYSTEM_PROP(PAYMENT_METHOD_TYPE_STORE, PKPaymentMethodTypeStore);

MAKE_SYSTEM_PROP(MERCHANT_CAPABILITY_3DS, PKMerchantCapability3DS);
MAKE_SYSTEM_PROP(MERCHANT_CAPABILITY_CREDIT, PKMerchantCapabilityCredit);
MAKE_SYSTEM_PROP(MERCHANT_CAPABILITY_DEBIT, PKMerchantCapabilityDebit);
MAKE_SYSTEM_PROP(MERCHANT_CAPABILITY_EMV, PKMerchantCapabilityEMV);

MAKE_SYSTEM_STR(PAYMENT_NETWORK_AMEX, PKPaymentNetworkAmex);
MAKE_SYSTEM_STR(PAYMENT_NETWORK_DISCOVER, PKPaymentNetworkDiscover);
MAKE_SYSTEM_STR(PAYMENT_NETWORK_MASTERCARD, PKPaymentNetworkMasterCard);
MAKE_SYSTEM_STR(PAYMENT_NETWORK_VISA, PKPaymentNetworkVisa);
MAKE_SYSTEM_STR(PAYMENT_NETWORK_PRIVATE_LABEL, PKPaymentNetworkPrivateLabel);

MAKE_SYSTEM_PROP(PAYMENT_SUMMARY_ITEM_TYPE_PENDING, PKPaymentSummaryItemTypePending);
MAKE_SYSTEM_PROP(PAYMENT_SUMMARY_ITEM_TYPE_FINAL, PKPaymentSummaryItemTypeFinal);

MAKE_SYSTEM_PROP(SHIPPING_TYPE_SHIPPING, PKShippingTypeShipping);
MAKE_SYSTEM_PROP(SHIPPING_TYPE_DELIVERY, PKShippingTypeDelivery);
MAKE_SYSTEM_PROP(SHIPPING_TYPE_SERVICE_PICKUP, PKShippingTypeServicePickup);
MAKE_SYSTEM_PROP(SHIPPING_TYPE_STORE_PICKUP, PKShippingTypeStorePickup);

MAKE_SYSTEM_PROP(ADDRESS_FIELD_NONE, PKAddressFieldNone);
MAKE_SYSTEM_PROP(ADDRESS_FIELD_POSTAL_ADDRESS, PKAddressFieldPostalAddress);
MAKE_SYSTEM_PROP(ADDRESS_FIELD_PHONE, PKAddressFieldPhone);
MAKE_SYSTEM_PROP(ADDRESS_FIELD_EMAIL, PKAddressFieldEmail);
MAKE_SYSTEM_PROP(ADDRESS_FIELD_NAME, PKAddressFieldName);
MAKE_SYSTEM_PROP(ADDRESS_FIELD_ALL, PKAddressFieldAll);

@end
