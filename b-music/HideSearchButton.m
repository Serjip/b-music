//
//  HideSearchButton.m
//  b-music
//
//  Created by Sergey P on 08.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "HideSearchButton.h"
#define thikess 2
@implementation HideSearchButton

- (void)drawRect:(NSRect)dirtyRect
{
    dirtyRect.size.width-=2;
    dirtyRect.size.height-=2;
    
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    
    if ([self.cell isHighlighted]) {
        CGContextSetStrokeColorWithColor(ctx, CGColorCreateGenericRGB(50/255.0, 50/255.0, 50/255.0, 1));
        CGContextSetRGBFillColor (ctx, 50/255.0, 50/255.0, 50/255.0, 1);
    }else{
        CGContextSetStrokeColorWithColor(ctx, CGColorCreateGenericRGB(60/255.0, 60/255.0, 60/255.0, 1));
        CGContextSetRGBFillColor (ctx, 60/255.0, 60/255.0, 60/255.0, 1);
    }
    
    
    double px=2;
    double py=2;
    double x1=dirtyRect.size.width-px;
    double y1=dirtyRect.size.height-py;
    double t=2.1;
    
    //----------------------
    CGContextSetLineWidth(ctx, 1);
    
    CGContextMoveToPoint(ctx, x1*0.6+t/2, y1*0.6+t/2);
    CGContextAddLineToPoint(ctx, t*1.5, t*1.5);
    
    CGContextMoveToPoint(ctx, t*1.5, y1*0.6+t/2);
    CGContextAddLineToPoint(ctx, x1*0.6+t/2, t*1.5);
    
    CGContextStrokePath(ctx);
    //----------------------
    
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineWidth(ctx, t);
    
    CGContextAddEllipseInRect(ctx, CGRectMake(t, t, x1*0.6, y1*0.6));
    CGContextStrokePath(ctx);
    
    CGContextMoveToPoint(ctx, x1*0.6+t/2, y1*0.6+t/2);
    CGContextAddLineToPoint(ctx, x1-t, y1-t);
    CGContextStrokePath(ctx);
}

@end
