//
//  CloseButton.m
//  LaMusique
//
//  Created by Sergey P on 23.08.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "CloseButton.h"

@implementation CloseButton

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
    
    double t=2.1;
    
    double x=dirtyRect.origin.x;
    double y=dirtyRect.origin.y;
    double x1=dirtyRect.size.width;
    double y1=dirtyRect.size.height;
    x+=t/2;
    y+=t/2;
    x1-=t/2;
    y1-=t/2;
    
    CGContextSetLineWidth(ctx, t);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    CGContextMoveToPoint(ctx, x, y1);
    CGContextAddLineToPoint(ctx, x1, y);
    
    CGContextStrokePath(ctx);
    
    CGContextMoveToPoint(ctx, x1, y1);
    CGContextAddLineToPoint(ctx, x, y);
    
    CGContextStrokePath(ctx);
}

@end
