//
//  Preferences.h
//  b-music
//
//  Created by Sergey P on 03.11.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  1. The above copyright notice and this permission notice shall be included
//     in all copies or substantial portions of the Software.
//
//  2. This Software cannot be used to archive or collect data such as (but not
//     limited to) that of events, news, experiences and activities, for the
//     purpose of any concept relating to diary/journal keeping.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <Cocoa/Cocoa.h>
#import "LastfmAPI.h"
#import "vkAPI.h"
#import "Settings.h"

@protocol PreferencesDelegate <NSObject>
-(void) updateMenuBarIcon;
-(void) updateDockIcon;
-(void) logoutVkFromPreferences;
@end

@interface Preferences : NSWindowController <NSToolbarDelegate>

@property (weak) id <PreferencesDelegate> delegate;

@property LastfmAPI * lastfmAPI;
@property vkAPI * vkAPI;
@property int showViewWithTag;

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
@property (weak) IBOutlet NSButton *visitProfileVkBtn;
@property (weak) IBOutlet NSImageView *avatarBtn;

- (IBAction)authorizationVk:(id)sender;
- (IBAction)visitProfileVk:(id)sender;
-(void) updateProfileVk;

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


/*
 *  Store Preferences
 *************************/
@property (weak) IBOutlet NSImageView *iconLockStore;
@property (weak) IBOutlet NSTextField *stateStore;
@property (weak) IBOutlet NSTextField *titleStore;
@property (weak) IBOutlet NSTextField *descriptionStore;
@property (weak) IBOutlet NSButton *purchaseBtnStore;
@property (weak) IBOutlet NSProgressIndicator *progressIndicatorStore;
@property (weak) IBOutlet NSButton *restorePurchaseBtn;
- (IBAction)restorePurchase:(id)sender;

- (IBAction)purchaseStore:(id)sender;
@end
