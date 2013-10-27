//
//  PlayButtonCell.m
//  LaMusique
//
//  Created by Sergey P on 25.08.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
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
    CGContextSetRGBFillColor(ctx, kRed/255.0, kGreen/255.0, kBlue/255.0, kAlpha);
    CGContextFillRect(ctx, dirtyRect);

    if ([self.cell isHighlighted]) {
        
    }else{
        
    }
    
    if(_pause){
        
    }else{
        
    }
}

-(void) setPauseState:(BOOL)state{
    _pause=state;
    [self setNeedsDisplay:YES];
}

//-(void)setImageURL:(NSString *)stringURL{
//    _imageview =[[NSImageView alloc] initWithFrame:self.bounds];
//    [_imageview setImage:[[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:stringURL]]];
//    [_imageview setImageScaling:NSImageScaleAxesIndependently];
//    [self addSubview:_imageview];
//}

-(void)mouseEntered:(NSEvent *)theEvent
{
    NSLog(@"EnterPlay");
}

-(void)mouseExited:(NSEvent *)theEvent
{
    NSLog(@"ExitPlay");
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
