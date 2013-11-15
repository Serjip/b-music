//
//  PurchaseManager.m
//  b-music
//
//  Created by Sergey P on 14.11.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "PurchaseManager.h"

#define productID @"com.ttitt.bmusic.unlock"

@implementation PurchaseManager

+ (PurchaseManager *)sharedInstance {
    static dispatch_once_t pred;
    static PurchaseManager *sharedInstance = nil;
    dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        //Transaction observer
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}

-(void)paymentQueue:(SKPaymentQueue *)queue
updatedTransactions:(NSArray *)transactions{
    
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
                // Call the appropriate custom method.
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                NSLog(@"SKPaymentTransactionStatePurchased %li",transaction.transactionState);
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                NSLog(@"SKPaymentTransactionStateFailed %li",transaction.transactionState);
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                NSLog(@"SKPaymentTransactionStateRestored: %li",transaction.transactionState);
            default:
                //NSLog(@"HZ paymentQueue default %ld",(long)transaction.transactionState);
                break;
        }
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error{
    NSLog(@"ERROR %@",error);
}

-(void)productsRequest:(SKProductsRequest *)request
    didReceiveResponse:(SKProductsResponse *)response{
    
    for (NSString *invalidIdentifier in response.invalidProductIdentifiers) {
        // Handle any invalid product identifiers.
        NSLog(@"%@",invalidIdentifier);
    }
    
    if (response.products.count) {
        SKProduct *product = [response.products objectAtIndex:0];
        [self validateProduct:product];
    }
}


-(void) validateProduct:(SKProduct*)product{
    
    if (![productID isEqualToString:product.productIdentifier]) {
        NSLog(@"FALED");
    }
    
    self.product=product;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setLocale:product.priceLocale];
    NSString *formattedPrice = [numberFormatter stringFromNumber:product.price];
    
    [self.delegate productInformation:product.localizedTitle
                          description:product.localizedDescription
                                price:formattedPrice];
}

/*
 *
 */
#pragma mark Public
-(void) getProductInfo{
    
    if([SKPaymentQueue canMakePayments]){
        SKProductsRequest * req=[[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:productID]];
        req.delegate = self;
        [req start];
        NSLog(@"Can make payments");
    }else{
        NSLog(@"Can't make SHIT");
        
    }
}

-(void) buyProduct{
    SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:self.product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void) restoreProduct{
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
    NSLog(@"Complete Transaction");
    
    if (![[transaction.payment productIdentifier] isEqual:productID]){
        NSLog(@"NAEB");
    }else{
        [self recordCompletedUnlock:transaction];
    }
        
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    NSLog(@"Restore Transaction");
    
    if (![[transaction.payment productIdentifier] isEqual:productID]){
        NSLog(@"NAEB");
    }else{
        [self recordCompletedUnlock:transaction];
    }
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}


- (void)failedTransaction:(SKPaymentTransaction *)transaction
{
    NSLog(@"Faled Transaction %@",transaction.error);
    
    
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        [self.delegate stateString:transaction.error.localizedDescription
                             color:[NSColor grayColor]];
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    }
    else
    {
        // this is fine, the user just cancelled, so don’t notify
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    }
}

-(void) recordCompletedUnlock:(SKPaymentTransaction *)transaction{
    NSLog(@"HERE WE SHOUD UNLOCK FEATURES");
}



@end
