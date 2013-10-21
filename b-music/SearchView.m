//
//  SearchView.m
//  b-music
//
//  Created by Sergey P on 21.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView

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
	[super drawRect:dirtyRect];
    // Drawing code here.
    
    NSRectFill(dirtyRect);
}

@end
