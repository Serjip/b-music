//
//  Preferences.h
//  b-music
//
//  Created by Sergey P on 03.11.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Preferences : NSWindowController <NSToolbarDelegate>

@property (weak) IBOutlet NSToolbar *toolbar;
@property (weak) IBOutlet NSView *mainView;
@property (strong) IBOutlet NSView *generalPreferencesView;

- (IBAction)switchView:(id)sender;
@end
