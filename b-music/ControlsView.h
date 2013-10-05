//
//  ControlsView.h
//  b-music
//
//  Created by Sergey P on 05.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol ControlsViewDelegate <NSObject>
-(void) isHovered:(BOOL)flag;
@end

@interface ControlsView : NSView

@property (weak) id <ControlsViewDelegate> delegate;

@end
