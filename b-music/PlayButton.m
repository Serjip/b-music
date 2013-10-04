//
//  PlayButton.m
//  b-music
//
//  Created by Sergey P on 03.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "PlayButton.h"

@implementation PlayButton

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    dirtyRect.size.width-=2;
    dirtyRect.size.height-=2;
    
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    
    if ([self.cell isHighlighted]) {
        CGContextSetStrokeColorWithColor(ctx, CGColorCreateGenericRGB(48/255.0, 98/255.0, 144/255.0, 1));
        CGContextSetRGBFillColor (ctx, 48/255.0, 98/255.0, 144/255.0, 1);
    }else{
        CGContextSetStrokeColorWithColor(ctx, CGColorCreateGenericRGB(150/255.0, 150/255.0, 150/255.0, 1));
        CGContextSetRGBFillColor (ctx, 150/255.0, 150/255.0, 150/255.0, 1);
    }
    
    //    CGContextSetAlpha(ctx, 0.5);
    
    double x1=dirtyRect.size.width;
    double y1=dirtyRect.size.height;
    double x0=dirtyRect.origin.x;
    double y0=dirtyRect.origin.y;
    
    double t=1;
    double p=10;
    
    CGContextSetLineWidth(ctx, t);
    CGContextStrokeEllipseInRect(ctx, CGRectMake(t/2, t/2, x1-t, y1-t));
    
    if(_pause){
        CGContextFillRect (ctx, CGRectMake (x0+p, y0+p, (x1-p*2)/3, y1-p*2 ));
        CGContextFillRect (ctx, CGRectMake (x0+p+(x1-p*2)*2/3, y0+p, (x1-p*2)/3, y1-p*2 ));
    }else{
        CGContextMoveToPoint(ctx, x0+p, y0+p);
        CGContextAddLineToPoint(ctx, x0+p , y1-p);
        CGContextAddLineToPoint(ctx, x1-p/1.1 , y1/2);
        CGContextClosePath(ctx);
    }
    
    CGContextFillPath(ctx);
}

-(void) setPauseState:(BOOL)state{
    _pause=state;
    [self setNeedsDisplay:YES];
}

@end
