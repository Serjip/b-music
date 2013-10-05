//
//  ControlsView.m
//  b-music
//
//  Created by Sergey P on 05.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "ControlsView.h"

@implementation ControlsView{
    NSTrackingArea * trackingArea;
}

-(void)mouseEntered:(NSEvent *)theEvent
{
    [_delegate isHovered:YES];
}

-(void)mouseExited:(NSEvent *)theEvent
{
    [_delegate isHovered:NO];
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
