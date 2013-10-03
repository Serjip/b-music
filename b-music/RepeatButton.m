//
//  RepeatButton.m
//  LaMusique
//
//  Created by Sergey P on 19.08.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "RepeatButton.h"

@implementation RepeatButton{
    BOOL _flag;
}

- (void)drawRect:(NSRect)dirtyRect
{
    dirtyRect.size.width-=2;
    dirtyRect.size.height-=2;
    
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    
    if (_flag) {
        if ([self.cell isHighlighted]) {
            CGContextSetStrokeColorWithColor(ctx, CGColorCreateGenericRGB(36/255.0, 72/255.0, 105/255.0, 1));
            CGContextSetRGBFillColor (ctx, 36/255.0, 72/255.0, 105/255.0, 1);
        }else{
            CGContextSetStrokeColorWithColor(ctx, CGColorCreateGenericRGB(48/255.0, 98/255.0, 144/255.0, 1));
            CGContextSetRGBFillColor (ctx, 48/255.0, 98/255.0, 144/255.0, 1);
        }
    }else{
        if ([self.cell isHighlighted]) {
            CGContextSetStrokeColorWithColor(ctx, CGColorCreateGenericRGB(50/255.0, 50/255.0, 50/255.0, 1));
            CGContextSetRGBFillColor (ctx, 50/255.0, 50/255.0, 50/255.0, 1);
        }else{
            CGContextSetStrokeColorWithColor(ctx, CGColorCreateGenericRGB(60/255.0, 60/255.0, 60/255.0, 1));
            CGContextSetRGBFillColor (ctx, 60/255.0, 60/255.0, 60/255.0, 1);
        }
    }
    
    double x1=dirtyRect.size.width;
    double y1=dirtyRect.size.height;
    double t=2.1;
    double ts=2.5;//Triangle size
    
    CGContextSetLineWidth(ctx, t);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextAddArc(ctx,x1/2, y1/2,y1/2-t/2-ts, 0 ,M_PI*1.5,0);
    
    CGContextStrokePath(ctx);
    
    //--------------Triangle
    
    CGContextSetLineWidth(ctx, t);
    
    CGContextMoveToPoint(ctx, x1/2, 0);
    CGContextAddLineToPoint(ctx, x1/2+ts*2.5, ts+t/2);
    CGContextAddLineToPoint(ctx, x1/2, ts*2+t);
    CGContextClosePath(ctx);
    
    CGContextFillPath(ctx);
}

-(void) setFlag:(BOOL)flag{
    _flag=flag;
    [self setNeedsDisplay:YES];
}

@end
