//
//  PlayButtonCell.m
//  LaMusique
//
//  Created by Sergey P on 25.08.13.
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

#import "PlayButtonCell.h"

#define kRed 31
#define kGreen 31
#define kBlue 31
#define kAlpha 1

@implementation PlayButtonCell{
    BOOL _pause;
    NSTrackingArea * _trackingArea;
    NSImageView * _imageview;
}

- (void)drawRect:(NSRect)dirtyRect
{
    
    
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    
    //Backgorund
    CGContextSetRGBFillColor(ctx, kRed/255.0, kGreen/255.0, kBlue/255.0, kAlpha);
    CGContextFillRect(ctx, self.bounds);

    
    
    [super drawRect:dirtyRect];
    
    CGFloat h=NSHeight(self.bounds);
    CGFloat w=NSWidth(self.bounds);
    CGFloat s=5;
    
    CGContextSetStrokeColorWithColor(ctx, [NSColor colorWithSRGBRed:1 green:1 blue:1 alpha:1].CGColor);
    CGContextSetRGBFillColor(ctx, 1, 1, 1, kAlpha);

    if ([self.cell isHighlighted]) {
        
    }else{
        
    }
    
    if(_pause){
        CGContextSetLineWidth(ctx, 2);
        CGContextMoveToPoint(ctx, w/2-s/2,h/2-s);
        CGContextAddLineToPoint(ctx, w/2-s/2, h/2+s);
        
        CGContextMoveToPoint(ctx, w/2+s/2,h/2-s);
        CGContextAddLineToPoint(ctx, w/2+s/2, h/2+s);
        CGContextStrokePath(ctx);
    }else{
        
        CGContextMoveToPoint(ctx, w/2-s/2,h/2-s);
        CGContextAddLineToPoint(ctx, w/2-s/2, h/2+s);
        
        CGContextAddLineToPoint(ctx, w/2+s/2, h/2);
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
        
    }
}

-(void) setPauseState:(BOOL)state{
    _pause=state;
    [self setNeedsDisplay:YES];
}

//-(void)mouseEntered:(NSEvent *)theEvent
//{
//}
//
//-(void)mouseExited:(NSEvent *)theEvent
//{
//}
//
//-(void)updateTrackingAreas
//{
//    if(_trackingArea != nil) {
//        [self removeTrackingArea:_trackingArea];
//    }
//    _trackingArea = [ [NSTrackingArea alloc] initWithRect:[self bounds]
//                                                 options:(NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways)
//                                                   owner:self
//                                                userInfo:nil];
//    [self addTrackingArea:_trackingArea];
//}

@end
