//
//  RemoveButtonCell.m
//  LaMusique
//
//  Created by Sergey P on 25.08.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "RemoveButtonCell.h"

#define kRed 210
#define kGreen 74
#define kBlue 67
#define kAlpha 1.0

@implementation RemoveButtonCell{
    BOOL mouseInside;
    NSTrackingArea *trackingArea;
}

- (void)drawRect:(NSRect)dirtyRect
{
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    CGContextSetRGBFillColor(ctx, kRed/255.0, kGreen/255.0, kBlue/255.0, kAlpha);
    CGContextFillRect(ctx, self.bounds);
    
    CGFloat h=NSHeight(self.bounds);
    CGFloat w=NSWidth(self.bounds);
    CGFloat s=7;
    CGContextSetStrokeColorWithColor(ctx, [NSColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor);
    CGContextSetLineWidth(ctx, 2);
    CGContextMoveToPoint(ctx, w/2-s,h/2);
    CGContextAddLineToPoint(ctx, w/2+s, h/2);
    CGContextStrokePath(ctx);
}

- (void)setMouseInside:(BOOL)value {
    if (mouseInside != value) {
        mouseInside = value;
        [self setNeedsDisplay:YES];
    }
}

- (BOOL)mouseInside {
    return mouseInside;
}

- (void)ensureTrackingArea {
    if (trackingArea == nil) {
        trackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect options:NSTrackingInVisibleRect | NSTrackingActiveAlways | NSTrackingMouseEnteredAndExited owner:self userInfo:nil];
    }
}

- (void)updateTrackingAreas {
    [super updateTrackingAreas];
    [self ensureTrackingArea];
    if (![[self trackingAreas] containsObject:trackingArea]) {
        [self addTrackingArea:trackingArea];
    }
}

- (void)mouseEntered:(NSEvent *)theEvent {
    self.mouseInside = YES;
}

- (void)mouseExited:(NSEvent *)theEvent {
    self.mouseInside = NO;
}

@end
