//
//  RemoveButtonCell.m
//  LaMusique
//
//  Created by Sergey P on 25.08.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  1. The above copyright notice and this permission notice shall be included
//     in all copies or substantial portions of the Software.
//
//  2. This Software cannot be used to archive or collect data such as (but not
//     limited to) that of events, news, experiences and activities, for the
//     purpose of any concept relating to diary/journal keeping.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "RemoveButtonCell.h"

#define kRed 210
#define kGreen 74
#define kBlue 67
#define kAlpha 1.0


#define kRedH 200
#define kGreenH 64
#define kBlueH 57
#define kAlphaH 1.0


@implementation RemoveButtonCell
//{
//    BOOL mouseInside;
//    NSTrackingArea *trackingArea;
//}

- (void)drawRect:(NSRect)dirtyRect
{
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    if ([self.cell isHighlighted]) {
        CGContextSetRGBFillColor(ctx, kRedH/255.0, kGreenH/255.0, kBlueH/255.0, kAlphaH);
    }else{
        CGContextSetRGBFillColor(ctx, kRed/255.0, kGreen/255.0, kBlue/255.0, kAlpha);
    }
    CGContextFillRect(ctx, self.bounds);
    
    [super drawRect:dirtyRect];
}

//- (void)setMouseInside:(BOOL)value {
//    if (mouseInside != value) {
//        mouseInside = value;
//        [self setNeedsDisplay:YES];
//    }
//}
//
//- (BOOL)mouseInside {
//    return mouseInside;
//}
//
//- (void)ensureTrackingArea {
//    if (trackingArea == nil) {
//        trackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect options:NSTrackingInVisibleRect | NSTrackingActiveAlways | NSTrackingMouseEnteredAndExited owner:self userInfo:nil];
//    }
//}
//
//- (void)updateTrackingAreas {
//    [super updateTrackingAreas];
//    [self ensureTrackingArea];
//    if (![[self trackingAreas] containsObject:trackingArea]) {
//        [self addTrackingArea:trackingArea];
//    }
//}
//
//- (void)mouseEntered:(NSEvent *)theEvent {
//    self.mouseInside = YES;
//}
//
//- (void)mouseExited:(NSEvent *)theEvent {
//    self.mouseInside = NO;
//}

@end
