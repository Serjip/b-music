//
//  PlayerWindow.m
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "PlayerWindow.h"

@implementation PlayerWindow

- (id)initWithContentRect:(NSRect)contentRect
                styleMask:(NSUInteger)windowStyle
                  backing:(NSBackingStoreType)bufferingType
                    defer:(BOOL)deferCreation
{
	self = [super
            initWithContentRect:contentRect
            styleMask:(NSBorderlessWindowMask | NSResizableWindowMask)
            backing:bufferingType
            defer:deferCreation];
	if (self)
	{
		[self setBackgroundColor:[NSColor clearColor]];
		[self setOpaque:NO];
        [self setMovableByWindowBackground:YES];
	}
    
    return self;
}

-(BOOL)canBecomeKeyWindow{
    return YES;
}
-(BOOL)canBecomeMainWindow{
    return YES;
}
- (BOOL)hasShadow {
    return YES;
}

//-(void)keyDown:(NSEvent *)theEvent{
////    NSLog(@"Player Vindow %hu",theEvent.keyCode);
//}

@end
