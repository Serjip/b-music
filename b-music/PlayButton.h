//
//  PlayButton.h
//  b-music
//
//  Created by Sergey P on 03.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PlayButton : NSButton{
    BOOL _pause;
}
-(void) setPause:(BOOL)state;
@end