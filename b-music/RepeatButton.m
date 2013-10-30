//
//  RepeatButton.m
//  LaMusique
//
//  Created by Sergey P on 19.08.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "RepeatButton.h"

#define kRed 50
#define kGreen 50
#define kBlue 50


#define kRed1 60
#define kGreen1 60
#define kBlue1 60



#define kRedH 48
#define kGreenH 98
#define kBlueH 144


#define kRedH1 36
#define kGreenH1 72
#define kBlueH1 105


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
            CGContextSetStrokeColorWithColor(ctx, [NSColor colorWithRed:kRedH1/255.0 green:kGreenH1/255.0 blue:kBlueH1/255.0 alpha:1].CGColor);
            CGContextSetRGBFillColor (ctx, kRedH1/255.0, kGreenH1/255.0, kBlueH1/255.0, 1);
        }else{
            CGContextSetStrokeColorWithColor(ctx, [NSColor colorWithRed:kRedH/255.0 green:kGreenH/255.0 blue:kBlueH/255.0 alpha:1].CGColor);
            CGContextSetRGBFillColor (ctx, kRedH/255.0, kGreenH/255.0, kBlueH/255.0, 1);
        }
    }else{
        if ([self.cell isHighlighted]) {
            CGContextSetStrokeColorWithColor(ctx, [NSColor colorWithRed:kRed/255.0 green:kGreen/255.0 blue:kBlue/255.0 alpha:1].CGColor);
            CGContextSetRGBFillColor (ctx, kRed/255.0, kGreen/255.0, kBlue/255.0, 1);
        }else{
            CGContextSetStrokeColorWithColor(ctx, [NSColor colorWithRed:kRed1/255.0 green:kGreen1/255.0 blue:kBlue1/255.0 alpha:1].CGColor);
            CGContextSetRGBFillColor (ctx, kRed1/255.0, kGreen1/255.0, kBlue1/255.0, 1);
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
