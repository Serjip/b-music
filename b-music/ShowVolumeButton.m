//
//  ShowVolumeButton.m
//  b-music
//
//  Created by Sergey P on 29.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "ShowVolumeButton.h"

#define kRed 0
#define kGreen 255
#define kBlue 0
#define kAlpha 1

@implementation ShowVolumeButton

- (void)drawRect:(NSRect)dirtyRect
{
	//[super drawRect:dirtyRect];
	
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    CGContextSetRGBFillColor(ctx, kRed/255.0, kGreen/255.0, kBlue/255.0, kAlpha);
    CGContextSetStrokeColorWithColor(ctx, [NSColor greenColor].CGColor);
    
    if ([self.cell isHighlighted]) {
        
    }else{
        
    }
    
    CGFloat h=NSHeight(self.bounds);
    CGFloat w=NSWidth(self.bounds);
    
    //------------------------------------------
    
    CGContextMoveToPoint(ctx, 0, h/4);
    CGContextAddLineToPoint(ctx, 0, h/4*3);
    
    CGContextAddLineToPoint(ctx, w/4, h/4*3);
    
    CGContextAddLineToPoint(ctx, w/4*2, h);
    
    CGContextAddLineToPoint(ctx, w/4*2, 0);
    
    CGContextAddLineToPoint(ctx, w/4, h/4);
    
    CGContextClosePath(ctx);
    
    CGContextFillPath(ctx);
    
    
    [[NSColor redColor]set];
    //------------------------------------------
    CGContextSetLineWidth(ctx, 1);
    CGContextAddArc(ctx, w/6, h/2, w-w/4, M_PI/6, M_PI*11/6, 1);
    CGContextStrokePath(ctx);
    CGContextAddArc(ctx, w/6, h/2, w/2, M_PI/6, M_PI*11/6, 1);
    
    CGContextStrokePath(ctx);
    
}

@end
