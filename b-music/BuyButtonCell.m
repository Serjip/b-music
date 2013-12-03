//
//  BuyButtonCell.m
//  b-music
//
//  Created by Sergey P on 24.11.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "BuyButtonCell.h"
#define kRed 42
#define kGreen 125
#define kBlue 206
#define kAlpha 1.0

#define kRedH 32
#define kGreenH 145
#define kBlueH 196
#define kAlphaH 1.0

@implementation BuyButtonCell

- (void)drawRect:(NSRect)dirtyRect
{
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    if ([self.cell isHighlighted]) {
        CGContextSetRGBFillColor(ctx, kRedH/255.0, kGreenH/255.0, kBlueH/255.0, kAlphaH);
    }else{
        CGContextSetRGBFillColor(ctx, kRed/255.0, kGreen/255.0, kBlue/255.0, kAlpha);
    }
    CGContextFillRect(ctx, dirtyRect);
    [super drawRect:dirtyRect];
}

@end
