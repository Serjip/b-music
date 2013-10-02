//
//  RuntimeSlider.m
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "RuntimeSlider.h"
#import "RuntimeSliderCell.h"

@implementation RuntimeSlider{
    NSTrackingArea * trackingArea;
}

-(void)setProgress:(double)progress{
    [self setDoubleValue:progress];
    
    double val=1-(self.maxValue-progress)/self.maxValue;
    [self.selectedCell setProgress:val];
    [self setNeedsDisplay:YES];
}

-(void)setBuffering:(double)buffering{
    [self.selectedCell setBuffering:buffering];
    [self setNeedsDisplay:YES];
}

-(void)mouseEntered:(NSEvent *)theEvent {
    [self.selectedCell setShowKnob:YES];
    [self setNeedsDisplay:YES];
}

-(void)mouseExited:(NSEvent *)theEvent
{
    [self.selectedCell setShowKnob:NO];
    [self setNeedsDisplay:YES];
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
