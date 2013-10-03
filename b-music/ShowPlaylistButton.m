//
//  ShowPlaylistButton.m
//  LaMusique
//
//  Created by Sergey P on 29.08.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "ShowPlaylistButton.h"

@implementation ShowPlaylistButton

//- (id)initWithFrame:(NSRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code here.
//    }
//    
//    return self;
//}
//
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
    
    
    double x1=dirtyRect.size.width;
    double y1=dirtyRect.size.height;
    double t=3;
    double px=2;
    double py=1;
    
    CGContextSetLineCap(ctx, kCGLineCapRound);//Round
    
    CGContextSetLineWidth(ctx, t);
    
    CGContextMoveToPoint(ctx, t+px, t+py);
    CGContextAddLineToPoint(ctx, x1-t-px, t+py);
    CGContextStrokePath(ctx);
    
    CGContextMoveToPoint(ctx, t+px, y1/2);
    CGContextAddLineToPoint(ctx, x1-t-px, y1/2);
    CGContextStrokePath(ctx);
    
    CGContextMoveToPoint(ctx, t+px, y1-t-py);
    CGContextAddLineToPoint(ctx, x1-t-px, y1-t-py);
    CGContextStrokePath(ctx);
}

@end
