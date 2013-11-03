//
//  MoreButtonCell.m
//  b-music
//
//  Created by Sergey P on 27.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "MoreButtonCell.h"

#define kRed 31
#define kGreen 31
#define kBlue 31
#define kAlpha 1

@implementation MoreButtonCell{
    NSTrackingArea * trackingArea;
    BOOL _isHovered;
}

- (void)drawRect:(NSRect)dirtyRect
{

    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    CGContextSetRGBFillColor(ctx, kRed/255.0, kGreen/255.0, kBlue/255.0, kAlpha);
    CGContextFillRect(ctx, self.bounds);

    [super drawRect:dirtyRect];
    
//
//    if ([self.cell isHighlighted]) {
//        
//    }else{
//        
//    }
//    
//    if (_isHovered) {
//        CGContextSetRGBFillColor(ctx, .07, .07, .07, kAlpha);
//        
//        CGContextAddEllipseInRect(ctx, NSMakeRect(10 , self.bounds.size.height/2-15/2, 5, 5));
//        CGContextAddEllipseInRect(ctx, NSMakeRect(30 , self.bounds.size.height/2-15/2, 5, 5));
//        CGContextAddEllipseInRect(ctx, NSMakeRect(50 , self.bounds.size.height/2-15/2, 5, 5));
//        
//        CGContextFillPath(ctx);
//    }else{
//        CGRect viewBounds = self.bounds;
//        
//        CGContextTranslateCTM(ctx, 0, viewBounds.size.height);
//        CGContextScaleCTM(ctx, 1, -1);
//        
//        CGFloat w, h;
//        w = self.bounds.size.width;
//        h = self.bounds. size.height;
//        
//        CGAffineTransform myTextTransform; // 2
//        CGContextSelectFont (ctx, // 3
//                             "Lucida Grande",
//                             12,
//                             kCGEncodingMacRoman);
//        CGContextSetCharacterSpacing (ctx, 1); // 4
//        CGContextSetTextDrawingMode (ctx, kCGTextFill); // 5
//        CGContextSetRGBFillColor (ctx, 0.7, 0.7, 0.7, 1); // 6
//        myTextTransform =  CGAffineTransformMakeRotation(0); // 8
//        CGContextSetTextMatrix (ctx, myTextTransform); // 9
//        CGContextShowTextAtPoint (ctx, 20, 20, [self.title cStringUsingEncoding:[NSString defaultCStringEncoding]], [self.title length]); // 10
//    }
}

-(void)mouseEntered:(NSEvent *)theEvent
{
    _isHovered=YES;
    [self setNeedsDisplay:YES];
}

-(void)mouseExited:(NSEvent *)theEvent
{
    _isHovered=NO;
    [self setNeedsDisplay:YES];
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
