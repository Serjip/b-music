//
//  ShowPlaylistButton.m
//  LaMusique
//
//  Created by Sergey P on 29.08.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "ShowPlaylistButton.h"

#define kRed 50
#define kGreen 50
#define kBlue 50


#define kRed1 60
#define kGreen1 60
#define kBlue1 60

@implementation ShowPlaylistButton

- (void)drawRect:(NSRect)dirtyRect
{
    dirtyRect.size.width-=2;
    dirtyRect.size.height-=2;
    
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    
    if ([self.cell isHighlighted]) {
        CGContextSetStrokeColorWithColor(ctx, [NSColor colorWithSRGBRed:kRed/255.0 green:kGreen/255.0 blue:kBlue/255.0 alpha:1].CGColor);
        CGContextSetRGBFillColor (ctx, kRed/255.0, kGreen/255.0, kBlue/255.0, 1);
    }else{
        CGContextSetStrokeColorWithColor(ctx, [NSColor colorWithSRGBRed:kRed1/255.0 green:kGreen1/255.0 blue:kBlue1/255.0 alpha:1].CGColor);
        CGContextSetRGBFillColor (ctx, kRed1/255.0, kGreen1/255.0, kBlue1/255.0, 1);
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
