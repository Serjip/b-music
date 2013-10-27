//
//  RemoveButtonCell.m
//  LaMusique
//
//  Created by Sergey P on 25.08.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "RemoveButtonCell.h"

#define red 40
#define green 40
#define blue 40
#define alpha 1.0

@implementation RemoveButtonCell{
    NSTrackingArea * _trackingArea;
}

- (void)drawRect:(NSRect)dirtyRect
{
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    
    CGContextSetRGBFillColor(ctx, red/255.0, green/255.0, blue/255.0, alpha);
    
    CGContextFillRect(ctx, dirtyRect);
}

-(void)mouseEntered:(NSEvent *)theEvent
{
    
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
