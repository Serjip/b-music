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
    NSImageView * _imageview;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageview =[[NSImageView alloc] initWithFrame:frame];
        [_imageview setImage:[[NSImage alloc] initWithContentsOfURL:[NSImage imageNamed:@"http://userserve-ak.last.fm/serve/300x300/93158109.png"]]];
        
        [self addSubview:_imageview];
        NSLog(@"HELLO %f %f %f %f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
    
    }
    return self;
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
