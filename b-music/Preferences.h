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

#import "PurchaseManager.h"
#import <StoreKit/StoreKit.h>


@protocol PreferencesDelegate <NSObject>
-(void) updateMenuBarIcon;
-(void) updateDockIcon;
-(void) logoutVkFromPreferences;
@end

@interface Preferences : NSWindowController <NSToolbarDelegate,PurchaseManagerDelegate>

@property (weak) id <PreferencesDelegate> delegate;


@property LastfmAPI * lastfmAPI;
@property vkAPI * vkAPI;
@property int showViewWithTag;

@property (weak) IBOutlet NSToolbar *toolbar;

@property (strong) IBOutlet NSView *generalPreferencesView;
@property (strong) IBOutlet NSView *lastfmPreferencesView;
@property (strong) IBOutlet NSView *vkPreferencesView;
@property (strong) IBOutlet NSView *storePreferencesView;

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
