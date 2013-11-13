//
//  SearchView.m
//  b-music
//
//  Created by Sergey P on 21.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "SearchView.h"

#define kRed 25
#define kGreen 25
#define kBlue 25
#define kAlpha 1

@implementation SearchView

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
    // Drawing code here.
    [[NSColor colorWithSRGBRed:kRed/255.0 green:kGreen/255.0 blue:kBlue/255.0 alpha:kAlpha] setFill];
    
    NSRectFill(self.bounds);
    
}

@end
