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
    NSTrackingArea * trackingArea;
    NSString * _t;
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
//    CGContextSetLineWidth(ctx, t);
//    
//    if (_complete) {
//        CGContextMoveToPoint(ctx, p, y1/2);
//        CGContextAddLineToPoint(ctx, x1/2-p , y1-p);
//        CGContextAddLineToPoint(ctx, x1-p , p);
//        CGContextStrokePath(ctx);
//    }else{
//        CGContextMoveToPoint(ctx, p, y1/2);
//        CGContextAddLineToPoint(ctx, x1-p , y1/2);
//        CGContextStrokePath(ctx);
//        
//        CGContextMoveToPoint(ctx, x1/2, p);
//        CGContextAddLineToPoint(ctx, x1/2 , y1-p);
//        CGContextStrokePath(ctx);
//    }
//}

-(void) setComplete{
    _complete=YES;
    [self setEnabled:NO];
    [self setImage:[NSImage imageNamed:@"NSMenuOnStateTemplate"]];
}

-(void)mouseEntered:(NSEvent *)theEvent
{
    if (_complete) {
        [self setImage:[NSImage imageNamed:@"NSMenuOnStateTemplate"]];
    }else{
        [self setImage:[NSImage imageNamed:@"NSAddTemplate"]];
    }
    _t=self.title;
    [self setTitle:@""];
}

-(void)mouseExited:(NSEvent *)theEvent
{
    [self setImage:nil];
    [self setTitle:_t];
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
