//
//  ShowVolumeButton.m
//  b-music
//
//  Created by Sergey P on 29.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "ShowVolumeButton.h"

#define kRed 50
#define kGreen 50
#define kBlue 50


#define kRed1 60
#define kGreen1 60
#define kBlue1 60

@implementation ShowVolumeButton

- (void)drawRect:(NSRect)dirtyRect
{
	//[super drawRect:dirtyRect];
	
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    
    if ([self.cell isHighlighted]) {
        CGContextSetStrokeColorWithColor(ctx, [NSColor colorWithSRGBRed:kRed/255.0 green:kGreen/255.0 blue:kBlue/255.0 alpha:1].CGColor);
        CGContextSetRGBFillColor (ctx, kRed/255.0, kGreen/255.0, kBlue/255.0, 1);
    }else{
        CGContextSetStrokeColorWithColor(ctx, [NSColor colorWithSRGBRed:kRed1/255.0 green:kGreen1/255.0 blue:kBlue1/255.0 alpha:1].CGColor);
        CGContextSetRGBFillColor (ctx, kRed1/255.0, kGreen1/255.0, kBlue1/255.0, 1);
    }
    
    CGFloat h=NSHeight(self.bounds);
    CGFloat w=NSWidth(self.bounds);
    CGFloat py=h*0.14;
    CGFloat px=w*0.1;
    
    //------------------------------------------
    
    CGContextMoveToPoint(ctx, px, h/4+py);
    CGContextAddLineToPoint(ctx, px, h/4*3-py);
    
    CGContextAddLineToPoint(ctx, w/4, h/4*3-py);
    
    CGContextAddLineToPoint(ctx, w/4*2, h-py);
    
    CGContextAddLineToPoint(ctx, w/4*2, py);
    
    CGContextAddLineToPoint(ctx, w/4, h/4+py);
    
    CGContextClosePath(ctx);
    
    CGContextFillPath(ctx);
    
    //------------------------------------------
    CGContextSetLineWidth(ctx, 1);
    CGContextAddArc(ctx, w/6, h/2, w-w/4, M_PI/6, M_PI*11/6, 1);
    CGContextStrokePath(ctx);
    CGContextAddArc(ctx, w/6, h/2, w/2, M_PI/6, M_PI*11/6, 1);
    
    CGContextStrokePath(ctx);
    
}

@end
