//
//  AddButtonCell.m
//  LaMusique
//
//  Created by Sergey P on 25.08.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "AddButtonCell.h"

#define kRed 119
#define kGreen 185
#define kBlue 126
#define kAlpha 1.0

#define kRedH 99
#define kGreenH 165
#define kBlueH 106
#define kAlphaH 1.0

@implementation AddButtonCell

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

-(void) setComplete{
    [self setImage:[NSImage imageNamed:@"NSMenuOnStateTemplate"]];
    [self setEnabled:NO];
}

@end
