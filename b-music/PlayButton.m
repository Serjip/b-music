//
//  PlayButton.m
//  b-music
//
//  Created by Sergey P on 03.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  1. The above copyright notice and this permission notice shall be included
//     in all copies or substantial portions of the Software.
//
//  2. This Software cannot be used to archive or collect data such as (but not
//     limited to) that of events, news, experiences and activities, for the
//     purpose of any concept relating to diary/journal keeping.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
        CGContextMoveToPoint(ctx, x1/2-2, p);
        CGContextAddLineToPoint(ctx, x1/2-2 , y1-p);
        CGContextMoveToPoint(ctx, x1/2+2, p);
        CGContextAddLineToPoint(ctx, x1/2+2 , y1-p);
        CGContextStrokePath(ctx);
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
