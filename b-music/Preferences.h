//
//  Preferences.h
//  b-music
//
//  Created by Sergey P on 03.11.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LastfmAPI.h"
#import "Settings.h"

@interface Preferences : NSWindowController <NSToolbarDelegate>

@property LastfmAPI * lastfmAPI;
@property Settings * se;

@property (weak) IBOutlet NSToolbar *toolbar;

@property (strong) IBOutlet NSView *generalPreferencesView;
@property (strong) IBOutlet NSView *lastfmPreferencesView;
@property (strong) IBOutlet NSView *vkPreferencesView;

- (IBAction)switchView:(id)sender;
- (IBAction)authorize:(id)sender;

@end
