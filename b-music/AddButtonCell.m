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
    BOOL _complete;
}

- (void)drawRect:(NSRect)dirtyRect
{
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    CGContextSetRGBFillColor(ctx, kRed/255.0, kGreen/255.0, kBlue/255.0, kAlpha);
    CGContextFillRect(ctx, self.bounds);
    
    CGFloat h=NSHeight(self.bounds);
    CGFloat w=NSWidth(self.bounds);
    CGFloat s=5;
    CGContextSetStrokeColorWithColor(ctx, [NSColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor);
    CGContextSetLineWidth(ctx, 2.1);
    
    if (_complete) {
        
        CGContextMoveToPoint(ctx, w/2-s,h/2);
        CGContextAddLineToPoint(ctx, w/2, h/2+s/2);
        CGContextAddLineToPoint(ctx, w/2+s, h/2-s);
        
    }else{
        CGContextMoveToPoint(ctx, w/2-s,h/2);
        CGContextAddLineToPoint(ctx, w/2+s, h/2);
    
        CGContextMoveToPoint(ctx, w/2,h/2-s);
        CGContextAddLineToPoint(ctx, w/2, h/2+s);
    }
    CGContextStrokePath(ctx);
}

-(void) setComplete{
    _complete=YES;
    [self setNeedsDisplay:YES];
    [self setEnabled:NO];
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
