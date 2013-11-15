//
//  PurchaseManager.h
//  b-music
//
//  Created by Sergey P on 14.11.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
@protocol PurchaseManagerDelegate <NSObject>

-(void)productInformation:(NSString *)title
              description:(NSString*)description
                    price:(NSString*)price
                 isUnlocked:(BOOL)isUnlocked;

-(void)stateString:(NSString *)text
             color:(NSColor *)color;

@end
@interface PurchaseManager : NSObject <SKPaymentTransactionObserver, SKRequestDelegate , SKProductsRequestDelegate>

@property (weak) id <PurchaseManagerDelegate> delegate;

+ (PurchaseManager *)sharedInstance;

-(void) getProductInfo;
-(void) buyProduct;
- (void) restoreProduct;

@end
