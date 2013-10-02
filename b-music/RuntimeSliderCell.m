//
//  RuntimeSliderCell.m
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "RuntimeSliderCell.h"

@implementation RuntimeSliderCell
- (id)init
{
    self = [super init];
    if (self) {
        _buffering=0.0;
    }
    return self;
}


- (void)drawBarInside:(NSRect)aRect flipped:(BOOL)flipped
{
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    
    CGContextSetStrokeColorWithColor(ctx, CGColorCreateGenericRGB(50/255.0, 50/255.0, 50/255.0, 1));
    
    double x1=aRect.size.width;
    double y1=aRect.size.height;
    
    double t1=2;
    double t2=2.5;
    
    CGContextSetLineCap(ctx, kCGLineCapRound);//Round
    CGContextSetLineWidth(ctx, t1);
    
    //Default
    CGContextMoveToPoint(ctx, t1/2, y1/2);
    CGContextAddLineToPoint(ctx, x1-t1/2, y1/2);
    CGContextStrokePath(ctx);
    
    
    CGContextSetLineWidth(ctx, t2);
    CGContextSetStrokeColorWithColor(ctx, CGColorCreateGenericRGB(20/255.0, 20/255.0, 20/255.0, 1));
    double aux;
    if (_buffering>.5) {
        aux=x1*_buffering-t2;;
    }else{
        aux=x1*_buffering+t2;
    }
    //Buffering
    CGContextMoveToPoint(ctx, t2, y1/2);
    CGContextAddLineToPoint(ctx, aux, y1/2);
    CGContextStrokePath(ctx);
    
    
    //Progress
    CGContextSetStrokeColorWithColor(ctx, CGColorCreateGenericRGB(48/255.0, 98/255.0, 144/255.0, 1));
    if (_progress>.5) {
        aux=x1*_progress-t1;
    }else{
        aux=x1*_progress+t1;
    }
    CGContextSetLineWidth(ctx, t1);
    CGContextMoveToPoint(ctx, t1/2, y1/2);
    CGContextAddLineToPoint(ctx, aux, y1/2);
    CGContextStrokePath(ctx);
}

- (void)drawKnob:(NSRect)knobRect{
    
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    
    CGContextSetRGBFillColor (ctx, 48/255.0, 98/255.0, 144/255.0, 1);
    
    double x0=knobRect.origin.x;
    double y0=knobRect.origin.y;
    double x1=knobRect.size.width;
    double y1=knobRect.size.height;
    double t=2;
    
    if (_isShowKnob) {
        
        CGContextFillEllipseInRect(ctx, CGRectMake(x0+t, y0+t, x1-t*2, y1-t*2));
        
    }else{
        
    }
}

-(void)setShowKnob:(BOOL)isShowKnob{
    _isShowKnob=isShowKnob;
}

- (BOOL)_usesCustomTrackImage
{
    return YES;
}
-(void)setBuffering:(double)buffering{
    _buffering=buffering;
}
-(void)setProgress:(double)progress{
    _progress=progress;
}
@end
