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
    NSTrackingArea * _trackingArea;
}

- (void)drawRect:(NSRect)dirtyRect
{
//    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
//    CGContextSetRGBFillColor(ctx, kRed/255.0, kGreen/255.0, kBlue/255.0, kAlpha);
//    CGContextFillRect(ctx, self.bounds);

    [[NSColor colorWithRed:kRed/255.0 green:kGreen/255.0 blue:kBlue/255.0 alpha:kAlpha] setFill];
    NSRectFill(self.bounds);
}

-(void)mouseEntered:(NSEvent *)theEvent
{
    NSLog(@"%f / ",NSHeight(self.bounds));
}

-(void)mouseExited:(NSEvent *)theEvent
{
    
}

-(void)updateTrackingAreas
{
    if(_trackingArea != nil) {
        [self removeTrackingArea:_trackingArea];
    }
    _trackingArea = [ [NSTrackingArea alloc] initWithRect:[self bounds]
                                                 options:(NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways)
                                                   owner:self
                                                userInfo:nil];
    [self addTrackingArea:_trackingArea];
}
@end
