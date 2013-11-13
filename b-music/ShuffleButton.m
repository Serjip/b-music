//
//  ShuffleButton.m
//  LaMusique
//
//  Created by Sergey P on 19.08.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "ShuffleButton.h"

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

@implementation ShuffleButton{
    BOOL _flag;
}

- (void)drawRect:(NSRect)dirtyRect
{
    dirtyRect.size.width-=2;
    dirtyRect.size.height-=2;
    
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    
    
    if (_flag) {
        if ([self.cell isHighlighted]) {
            CGContextSetStrokeColorWithColor(ctx, [NSColor colorWithSRGBRed:kRedH1/255.0 green:kGreenH1/255.0 blue:kBlueH1/255.0 alpha:1].CGColor);
            CGContextSetRGBFillColor (ctx, kRedH1/255.0, kGreenH1/255.0, kBlueH1/255.0, 1);
        }else{
            CGContextSetStrokeColorWithColor(ctx, [NSColor colorWithSRGBRed:kRedH/255.0 green:kGreenH/255.0 blue:kBlueH/255.0 alpha:1].CGColor);
            CGContextSetRGBFillColor (ctx, kRedH/255.0, kGreenH/255.0, kBlueH/255.0, 1);
        }
    }else{
        if ([self.cell isHighlighted]) {
            CGContextSetStrokeColorWithColor(ctx, [NSColor colorWithSRGBRed:kRed/255.0 green:kGreen/255.0 blue:kBlue/255.0 alpha:1].CGColor);
            CGContextSetRGBFillColor (ctx, kRed/255.0, kGreen/255.0, kBlue/255.0, 1);
        }else{
            CGContextSetStrokeColorWithColor(ctx, [NSColor colorWithSRGBRed:kRed1/255.0 green:kGreen1/255.0 blue:kBlue1/255.0 alpha:1].CGColor);
            CGContextSetRGBFillColor (ctx, kRed1/255.0, kGreen1/255.0, kBlue1/255.0, 1);
        }
    }
    
    double ts=3.2;
    double pt=2;
    
    double x1=dirtyRect.size.width;
    double y1=dirtyRect.size.height-pt;
    double y0=dirtyRect.origin.y+pt;
    
    CGContextMoveToPoint(ctx, x1-ts*1.5, y1-2*ts);
    CGContextAddLineToPoint(ctx, x1, y1-ts);
    CGContextAddLineToPoint(ctx, x1-ts*1.5, y1);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    
    CGContextMoveToPoint(ctx, x1-ts*1.5, y0+2*ts);
    CGContextAddLineToPoint(ctx, x1, y0+ts);
    CGContextAddLineToPoint(ctx, x1-ts*1.5, y0);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    
    
    double t=2.2;//Thikness
    double p=4;//Padding y
    
    double xc0=0;
    double yc0=t/2+p;
    
    double xc1=dirtyRect.size.width-ts*1.5;
    double yc1=dirtyRect.size.height-t/2-p;
    
    
    CGContextSetLineWidth(ctx, t);
    
    CGContextMoveToPoint(ctx, xc0, yc0);
    CGContextAddCurveToPoint(ctx, xc1*.3,yc0 , xc1*.3,yc0 , xc1*.38,(yc1+yc0)*.38);
    
    CGContextMoveToPoint(ctx, xc1*.62, (yc1+yc0)*.62);
    CGContextAddCurveToPoint(ctx, xc1*.7,yc1 , xc1*.7,yc1 , xc1,yc1);
    CGContextStrokePath(ctx);
    
    
    CGContextMoveToPoint(ctx, xc0, yc1);
    CGContextAddCurveToPoint(ctx, xc1*.3,yc1 , xc1*.3,yc1 , xc1*.5,(yc1+yc0)*.5);
    CGContextAddCurveToPoint(ctx, xc1*.7,yc0 , xc1*.7,yc0 , xc1,yc0);
    CGContextStrokePath(ctx);

}

-(void) setFlag:(BOOL)flag{
    _flag=flag;
    [self setNeedsDisplay:YES];
}
@end
