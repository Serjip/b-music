//
//  HideSearchButton.m
//  b-music
//
//  Created by Sergey P on 08.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "HideSearchButton.h"
#define thikess 2
@implementation HideSearchButton

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    
    if ([self.cell isHighlighted]) {
        CGContextSetStrokeColorWithColor(ctx, CGColorCreateGenericRGB(50/255.0, 50/255.0, 50/255.0, 1));
        CGContextSetRGBFillColor (ctx, 50/255.0, 50/255.0, 50/255.0, 1);
    }else{
        CGContextSetStrokeColorWithColor(ctx, CGColorCreateGenericRGB(60/255.0, 60/255.0, 60/255.0, 1));
        CGContextSetRGBFillColor (ctx, 60/255.0, 60/255.0, 60/255.0, 1);
    }
    
    NSBezierPath* thePath = [NSBezierPath bezierPath];
    
    [thePath setLineWidth:thikess];
    CGRect aRect=NSMakeRect(self.bounds.origin.x+thikess, self.bounds.origin.y+thikess, self.bounds.size.width-2*thikess, self.bounds.size.height-2*thikess);
    [thePath appendBezierPathWithRoundedRect:aRect xRadius:8 yRadius:8];
    [thePath stroke];
    
}

@end
