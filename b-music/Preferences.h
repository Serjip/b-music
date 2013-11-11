//
//  Preferences.h
//  b-music
//
//  Created by Sergey P on 03.11.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LastfmAPI.h"
#import "vkAPI.h"
#import "Settings.h"


@protocol PreferencesDelegate <NSObject>
-(void) updateMenuBarIcon;
-(void) updateDockIcon;
@end

@interface Preferences : NSWindowController <NSToolbarDelegate>

@property (weak) id <PreferencesDelegate> delegate;


@property LastfmAPI * lastfmAPI;
@property vkAPI * vkAPI;

@property (weak) IBOutlet NSToolbar *toolbar;

@property (strong) IBOutlet NSView *generalPreferencesView;
@property (strong) IBOutlet NSView *lastfmPreferencesView;
@property (strong) IBOutlet NSView *vkPreferencesView;

- (IBAction)switchView:(id)sender;

/*
 *  Generl Preferences
 *************************/

@property (strong) IBOutlet NSButton * showMenubarIconGeneralBtn;
@property (strong) IBOutlet NSButton * showDockIconArtworkGeneralBtn;
@property (strong) IBOutlet NSButton * searchArtworkGeneralBtn;
@property (strong) IBOutlet NSButton * showNotaficationGeneralBtn;

- (IBAction)showMenubarIconGeneral:(id)sender;
- (IBAction)showDockIconArtworkGeneral:(id)sender;
- (IBAction)searchArtworkGeneral:(id)sender;
- (IBAction)showNotaficationGeneral:(id)sender;

/*
 *  VK Preferences
 *************************/
@property (weak) IBOutlet NSButton *authorizationVkBtn;

- (IBAction)authorizationVk:(id)sender;

/*
 *  Lastfm Preferences
 *************************/
@property (weak) IBOutlet NSButton *authorizeLastfmBtn;
@property (weak) IBOutlet NSButton *nowPlayingLastfmBtn;
@property (weak) IBOutlet NSButton *scrobbleTracksLastfmBtn;
@property (weak) IBOutlet NSButton *visitProfileLastfmBtn;

- (IBAction)authorizeLastfm:(id)sender;
- (IBAction)nowPlayingLastfm:(id)sender;
- (IBAction)scrobbleTracksLastfm:(id)sender;
- (IBAction)visitProfileLastfm:(id)sender;

-(void) updateProfileLastfm;


@end
