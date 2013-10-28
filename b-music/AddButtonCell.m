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

@implementation AddButtonCell{
    NSTrackingArea * trackingArea;
}

- (void)drawRect:(NSRect)dirtyRect
{
//    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
//    CGContextSetRGBFillColor(ctx, kRed/255.0, kGreen/255.0, kBlue/255.0, kAlpha);
//    CGContextFillRect(ctx, self.bounds);
    [[NSColor colorWithRed:kRed/255.0 green:kGreen/255.0 blue:kBlue/255.0 alpha:kAlpha] setFill];
    NSRectFill(self.bounds);
}

-(void) setComplete{
}

-(void)mouseEntered:(NSEvent *)theEvent
{
}

-(void)mouseExited:(NSEvent *)theEvent
{
}

-(void)updateTrackingAreas
{
    if(trackingArea != nil) {
        [self removeTrackingArea:trackingArea];
    }
    trackingArea = [ [NSTrackingArea alloc] initWithRect:[self bounds]
                                                 options:(NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways)
                                                   owner:self
                                                userInfo:nil];
    [self addTrackingArea:trackingArea];
}
@end
