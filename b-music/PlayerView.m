//
//  PlayerView.m
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "PlayerView.h"

#define kRed 31
#define kGreen 31
#define kBlue 31
#define kAlpha 1

@implementation PlayerView
- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor colorWithSRGBRed:kRed/255.0 green:kGreen/255.0 blue:kBlue/255.0 alpha:kAlpha] setFill];    
    NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:[self bounds] xRadius:10 yRadius:10];
    [path fill];
}
@end
