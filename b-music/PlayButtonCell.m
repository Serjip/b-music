//
//  PlayButtonCell.m
//  LaMusique
//
//  Created by Sergey P on 25.08.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "PlayButtonCell.h"

@implementation PlayButtonCell{
    BOOL _pause;
    NSTrackingArea * _trackingArea;
    NSImageView * _imageview;
}

//- (void)drawRect:(NSRect)dirtyRect
//{
//    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
//    CGContextSetRGBFillColor(ctx, red/255.0, green/255.0, blue/255.0, 1.0);
//    CGContextFillRect(ctx, dirtyRect);
//
//    if ([self.cell isHighlighted]) {
//        CGContextSetStrokeColorWithColor(ctx, CGColorCreateGenericRGB(120/255.0, 120/255.0, 120/255.0, 1));
//        CGContextSetRGBFillColor (ctx, 120/255.0, 120/255.0, 120/255.0, 1);
//    }else{
//        CGContextSetStrokeColorWithColor(ctx, CGColorCreateGenericRGB(150/255.0, 150/255.0, 150/255.0, 1));
//        CGContextSetRGBFillColor (ctx, 150/255.0, 150/255.0, 150/255.0, 1);
//    }
//    
//    CGContextSetLineWidth(ctx, thikness);
//    CGContextStrokeEllipseInRect(ctx, CGRectMake(thikness, thikness, w-2*thikness, h-2*thikness));
//    
//    if(_pause){
//        CGContextSetLineWidth(ctx, thikness*2);
//        CGContextMoveToPoint(ctx, w/2-3, p);
//        CGContextAddLineToPoint(ctx, w/2-3 , h-p);
//        CGContextMoveToPoint(ctx, w/2+3, p);
//        CGContextAddLineToPoint(ctx, w/2+3 , h-p);
//        CGContextStrokePath(ctx);
//    }else{
//        CGContextMoveToPoint(ctx, p, p);
//        CGContextAddLineToPoint(ctx, p , h-p);
//        CGContextAddLineToPoint(ctx, w-p/1.1 , h/2);
//        CGContextClosePath(ctx);
//    }
//    CGContextFillPath(ctx);
//    
//}
//
//-(BOOL)wantsUpdateLayer{
//    return YES;
//}
//
//-(void)updateLayer{
//    self.layer.backgroundColor =[NSColor colorWithCalibratedRed:31/255.0 green:31/255.0 blue:31/255.0 alpha:1.0].CGColor;
//}

-(void) setPauseState:(BOOL)state{
    _pause=state;
    [self setNeedsDisplay:YES];
}

-(void)setImageURL:(NSString *)stringURL{
    _imageview =[[NSImageView alloc] initWithFrame:self.bounds];
    [_imageview setImage:[[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:stringURL]]];
    [_imageview setImageScaling:NSImageScaleAxesIndependently];
    [self addSubview:_imageview];
}

-(void)mouseEntered:(NSEvent *)theEvent
{
    NSLog(@"EnterPlay %@",[self.subviews objectAtIndex:0]);
    [_imageview setAlphaValue:1.0];
}

-(void)mouseExited:(NSEvent *)theEvent
{
    NSLog(@"ExitPlay");
    [_imageview setAlphaValue:0.4];
}

-(void)updateTrackingAreas
{
    if(_trackingArea != nil) {
        [self removeTrackingArea:_trackingArea];
    }
    _trackingArea = [ [NSTrackingArea alloc] initWithRect:[self bounds]
                                                 options:(NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways)
                                                   owner:self
                                                userInfo:nil];
    [self addTrackingArea:_trackingArea];
}

@end
