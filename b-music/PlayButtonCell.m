//
//  PlayButtonCell.m
//  LaMusique
//
//  Created by Sergey P on 25.08.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "PlayButtonCell.h"

#define thikness 1
#define h 44
#define w 44

#define p 17

@implementation PlayButtonCell

- (void)drawRect:(NSRect)dirtyRect
{
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    
    if ([self.cell isHighlighted]) {
        CGContextSetStrokeColorWithColor(ctx, CGColorCreateGenericRGB(120/255.0, 120/255.0, 120/255.0, 1));
        CGContextSetRGBFillColor (ctx, 120/255.0, 120/255.0, 120/255.0, 1);
    }else{
        CGContextSetStrokeColorWithColor(ctx, CGColorCreateGenericRGB(150/255.0, 150/255.0, 150/255.0, 1));
        CGContextSetRGBFillColor (ctx, 150/255.0, 150/255.0, 150/255.0, 1);
    }
    
    CGContextSetLineWidth(ctx, thikness);
    CGContextStrokeEllipseInRect(ctx, CGRectMake(thikness, thikness, w-2*thikness, h-2*thikness));
    
    if(_pause){
        CGContextSetLineWidth(ctx, thikness*2);
        CGContextMoveToPoint(ctx, w/2-3, p);
        CGContextAddLineToPoint(ctx, w/2-3 , h-p);
        CGContextMoveToPoint(ctx, w/2+3, p);
        CGContextAddLineToPoint(ctx, w/2+3 , h-p);
        CGContextStrokePath(ctx);
    }else{
        CGContextMoveToPoint(ctx, p, p);
        CGContextAddLineToPoint(ctx, p , h-p);
        CGContextAddLineToPoint(ctx, w-p/1.1 , h/2);
        CGContextClosePath(ctx);
    }
    
    CGContextFillPath(ctx);
}

-(void) setPauseState:(BOOL)state{
    _pause=state;
    [self setNeedsDisplay:YES];
}

@end
