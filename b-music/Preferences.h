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

/*
 *  VK Preferences
 *************************/
@property (weak) IBOutlet NSButton *authorizationVkBtn;
@property (weak) IBOutlet NSButton *offlineVkBtn;

- (IBAction)authorizationVk:(id)sender;
- (IBAction)offlineVk:(id)sender;

/*
 *  Lastfm Preferences
 *************************/
@property (weak) IBOutlet NSButton *authorizeLastfmBtn;
@property (weak) IBOutlet NSButton *nowPlayingLastfmBtn;
@property (weak) IBOutlet NSButton *scrobbleTracksLastfmBtn;

- (IBAction)authorizeLastfm:(id)sender;
- (IBAction)nowPlayingLastfm:(id)sender;
- (IBAction)scrobbleTracksLastfm:(id)sender;


@end
