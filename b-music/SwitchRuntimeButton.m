//
//  SwitchRuntimeButton.m
//  b-music
//
//  Created by Sergey P on 03.11.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "SwitchRuntimeButton.h"

@implementation SwitchRuntimeButton

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
	// Drawing code here.
    
    
    NSColor *color = [NSColor grayColor];
    
    NSMutableAttributedString *colorTitle =
    
    [[NSMutableAttributedString alloc] initWithAttributedString:[self attributedTitle]];
    
    NSRange titleRange = NSMakeRange(0, [colorTitle length]);
    
    [colorTitle addAttribute:NSForegroundColorAttributeName value:color range:titleRange];
    
    [self setAttributedTitle:colorTitle];
    
    
    [super drawRect:dirtyRect];

}

@end
