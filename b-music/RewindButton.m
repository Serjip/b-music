//
//  RewindButton.m
//  LaMusique
//
//  Created by Sergey P on 19.08.13.
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

#import "RewindButton.h"

@implementation RewindButton

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
    
    double t=1;
    
    double x0=dirtyRect.origin.x;
    double y0=dirtyRect.origin.y;
    double x1=dirtyRect.size.width;
    double y1=dirtyRect.size.height;
    
    CGContextSetLineWidth(ctx, t);
    CGContextStrokeEllipseInRect(ctx, CGRectMake(t/2, t/2, x1-t, y1-t));
    
    //-------Triangle1
    double px=10;
    double py=11;
    
    CGContextMoveToPoint(ctx, x1-px, y1-py);
    CGContextAddLineToPoint(ctx, x1-px, y0+py);
    CGContextAddLineToPoint(ctx, x1/2, y1/2);
    CGContextClosePath(ctx);
    
    CGContextFillPath(ctx);
    
    
    CGContextMoveToPoint(ctx, x1*.5, y0+py);
    CGContextAddLineToPoint(ctx, x1*.5, y1-py);
    CGContextAddLineToPoint(ctx, x0+px, y1/2);
    CGContextClosePath(ctx);
    
    CGContextFillPath(ctx);
}

//-(BOOL)wantsUpdateLayer{
//    return YES;
//}
//
//-(void)updateLayer{
//    if ([self.cell isHighlighted]) {
//        self.layer.contents=[NSImage imageNamed:@"rewind.png"];
//    }else{
//        self.layer.contents=[NSImage imageNamed:@"rewind.png"];
//    }
//    
//}

@end
