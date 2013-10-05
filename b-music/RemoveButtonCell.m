//
//  RemoveButtonCell.m
//  LaMusique
//
//  Created by Sergey P on 25.08.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "RemoveButtonCell.h"

@implementation RemoveButtonCell{
    NSTrackingArea * trackingArea;
}

//- (void)drawRect:(NSRect)dirtyRect
//{
//    double x1=self.frame.size.width;
//    double y1=self.frame.size.height;
//    
//    double t=2.1;
//    double p=7;
//    
//    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
//    
//    if ([self.cell isHighlighted]) {
//        CGContextSetStrokeColorWithColor(ctx, CGColorCreateGenericRGB(120/255.0, 120/255.0, 120/255.0, 1));
//        CGContextSetRGBFillColor (ctx, 120/255.0, 120/255.0, 120/255.0, 1);
//    }else{
//        CGContextSetStrokeColorWithColor(ctx, CGColorCreateGenericRGB(150/255.0, 150/255.0, 150/255.0, 1));
//        CGContextSetRGBFillColor (ctx, 150/255.0, 150/255.0, 150/255.0, 1);
//    }
//    
//    CGContextSetLineCap(ctx, kCGLineCapRound);
//    
//    CGContextSetLineWidth(ctx, t);
//    CGContextMoveToPoint(ctx, p, y1/2);
//    CGContextAddLineToPoint(ctx, x1-p , y1/2);
//    CGContextStrokePath(ctx);
//}

-(void)mouseEntered:(NSEvent *)theEvent
{
    NSLog(@"%@",self.title);
}

-(void)mouseExited:(NSEvent *)theEvent
{
    
}

-(void)updateTrackingAreas
{
    if(trackingArea != nil) {
        [self removeTrackingArea:trackingArea];
    }
    trackingArea = [ [NSTrackingArea alloc] initWithRect:[self bounds]
                                                 options:(NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways)
                                                   owner:self
                                                userInfo:nil];
    [self addTrackingArea:trackingArea];
}
@end
