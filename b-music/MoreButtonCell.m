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

@implementation MoreButtonCell

- (void)drawRect:(NSRect)dirtyRect
{
//    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
//    CGContextSetRGBFillColor(ctx, kRed/255.0, kGreen/255.0, kBlue/255.0, kAlpha);
//    CGContextFillRect(ctx, dirtyRect);
    
    [[NSColor colorWithRed:kRed/255.0 green:kGreen/255.0 blue:kBlue/255.0 alpha:kAlpha] setFill];
    NSRectFill(self.bounds);
    
    if ([self.cell isHighlighted]) {
        
    }else{
        
    }
}

@end
