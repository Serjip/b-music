//
//  VolumeCell.m
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "VolumeCell.h"

#define posY 8.5
#define thikness 2

@implementation VolumeCell{
    double _progress;
}

- (id)init
{
    self = [super init];
    if (self) {
        _progress=0.0;
    }
    return self;
}


- (void)drawBarInside:(NSRect)aRect flipped:(BOOL)flipped
{
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    
    CGContextSetLineCap(ctx, kCGLineCapRound);//Round
    CGContextSetLineWidth(ctx, thikness);
    
    //Default
    CGContextSetStrokeColorWithColor(ctx, CGColorCreateGenericRGB(50/255.0, 50/255.0, 50/255.0, 1));
    CGContextMoveToPoint(ctx, aRect.origin.x+1, posY);
    CGContextAddLineToPoint(ctx, aRect.size.width, posY);
    CGContextStrokePath(ctx);
    
    //Progress
    CGContextSetStrokeColorWithColor(ctx, CGColorCreateGenericRGB(20/255.0, 20/255.0, 20/255.0, 1));
    CGContextMoveToPoint(ctx, aRect.origin.x+1, posY);
    CGContextAddLineToPoint(ctx, aRect.size.width*_progress+2*(1-_progress), posY);
    CGContextStrokePath(ctx);
}

- (void)drawKnob:(NSRect)knobRect{
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    
    CGContextSetRGBFillColor (ctx, 20/255.0, 20/255.0, 20/255.0, 1);
    
    double x0=knobRect.origin.x;
    double y0=knobRect.origin.y;
    double x1=knobRect.size.width;
    double y1=knobRect.size.height;
    double t=2;

        
    CGContextFillEllipseInRect(ctx, CGRectMake(x0+t, y0+t, x1-t*2, y1-t*2));
}
- (BOOL)_usesCustomTrackImage
{
    return YES;
}
-(void)setProgress:(double)progress{
    _progress=progress;
}
@end
