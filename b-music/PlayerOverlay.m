//
//  PlayerOverlay.m
//  b-music
//
//  Created by Sergey P on 10.11.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "PlayerOverlay.h"

#define kRed 200
#define kGreen 200
#define kBlue 200
#define kAlpha 0.8

@implementation PlayerOverlay

- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor colorWithSRGBRed:kRed/255.0 green:kGreen/255.0 blue:kBlue/255.0 alpha:kAlpha] setFill];
    NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:[self bounds] xRadius:10 yRadius:10];
    [path fill];
    [super drawRect:dirtyRect];
}

@end
