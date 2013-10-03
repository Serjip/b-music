//
//  AddButtonCell.m
//  LaMusique
//
//  Created by Sergey P on 25.08.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "AddButtonCell.h"

@implementation AddButtonCell{
    BOOL _complete;
}

- (void)drawRect:(NSRect)dirtyRect
{
    double x1=dirtyRect.size.width;
    double y1=dirtyRect.size.height;
    
    double t=2.1;
    double p=7;
    
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    
    if ([self.cell isHighlighted]) {
        CGContextSetStrokeColorWithColor(ctx, CGColorCreateGenericRGB(120/255.0, 120/255.0, 120/255.0, 1));
        CGContextSetRGBFillColor (ctx, 120/255.0, 120/255.0, 120/255.0, 1);
    }else{
        CGContextSetStrokeColorWithColor(ctx, CGColorCreateGenericRGB(150/255.0, 150/255.0, 150/255.0, 1));
        CGContextSetRGBFillColor (ctx, 150/255.0, 150/255.0, 150/255.0, 1);
    }
    
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineWidth(ctx, t);
    
    if (_complete) {
        CGContextMoveToPoint(ctx, p, y1/2);
        CGContextAddLineToPoint(ctx, x1/2-p , y1-p);
        CGContextAddLineToPoint(ctx, x1-p , p);
        CGContextStrokePath(ctx);
    }else{
        CGContextMoveToPoint(ctx, p, y1/2);
        CGContextAddLineToPoint(ctx, x1-p , y1/2);
        CGContextStrokePath(ctx);
        
        CGContextMoveToPoint(ctx, x1/2, p);
        CGContextAddLineToPoint(ctx, x1/2 , y1-p);
        CGContextStrokePath(ctx);
    }
}

-(void) setComplete{
    _complete=YES;
    [self setEnabled:NO];
    [self setNeedsDisplay:YES];
}

@end