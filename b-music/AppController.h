//
//  AppController.h
//  b-music
//
//  Created by Sergey P on 01.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RuntimeSlider.h"
#import "Volume.h"

#import "RepeatButton.h"
#import "ShuffleButton.h"
#import "ShowSearchButton.h"

#import "TableCellView.h"

#import "PlayButton.h"
#import "PlayButtonCell.h"
#import "PlayerController.h"

#import "AddButtonCell.h"
#import "RemoveButtonCell.h"

#import "ControlsView.h"
#import "Settings.h"

#import "vkAPI.h"
#import "LastfmAPI.h"

#import "Preferences.h"

@interface AppController : NSObject<NSWindowDelegate,
                                    NSTableViewDataSource,
                                    NSTableViewDelegate,
                                    NSUserNotificationCenterDelegate,
                                    PlayerDelegate,
                                    ControlsViewDelegate,
                                    vkAPIDelegate,
                                    LastfmAPIDelegate,
                                    PreferencesDelegate>{
    NSStatusItem *statusItem;
    Preferences * preferences;
}

@property PlayerController * PC;
@property vkAPI * vkAPI;
@property LastfmAPI * lastfmAPI;

@property (weak) IBOutlet NSPopover *popoverVolume;
@property (weak) IBOutlet NSScrollView *scrollview;
@property (weak) IBOutlet NSTableView * tableview;
@property (weak) IBOutlet ControlsView *Controls0;
@property (weak) IBOutlet NSView *Controls1;
@property (weak) IBOutlet NSView *Controls2;
@property (weak) IBOutlet NSView *lockView;

@property (weak) IBOutlet Volume *volume;

@property (weak) IBOutlet NSLayoutConstraint *searchViewHeight;
@property (weak) IBOutlet NSSearchField *searchField;

@property (weak) IBOutlet NSView *BottomControls0;
@property (weak) IBOutlet NSView *BottomControls1;

@property (weak) IBOutlet NSMenu *controlsMenu;
@property (weak) IBOutlet NSMenu *editMenu;
@property (weak) IBOutlet NSMenu *viewMenu;
@property (weak) IBOutlet NSMenu *windowMenu;
@property (weak) IBOutlet NSMenu *dockMenu;
@property (weak) IBOutlet NSMenu *statusMenu;


#pragma mark -
#pragma mark IBAcrions
-(IBAction)supportLockScreen:(id)sender;

-(IBAction)loginAuthVk:(id)sender;
-(IBAction)signupAuthVk:(id)sender;

-(IBAction)preferences:(id)sender;

-(IBAction)play:(id)sender;
-(IBAction)next:(id)sender;
-(IBAction)previous:(id)sender;
-(IBAction)decreaseVolume:(id)sender;
-(IBAction)increaseVolume:(id)sender;
-(IBAction)mute:(id)sender;

-(IBAction)shuffle:(id)sender;
-(IBAction)repeat:(id)sender;
-(IBAction)alwaysOnTop:(id)sender;
-(IBAction)visitWebsite:(id)sender;

-(IBAction)more:(id)sender;
-(IBAction)buyInItunec:(id)sender;
-(IBAction)addTrack:(id)sender;
-(IBAction)removeTrack:(id)sender;

-(IBAction)showVolume:(id)sender;
-(IBAction)volume:(id)sender;

-(IBAction)runtime:(id)sender;
-(IBAction)switchRuntime:(id)sender;
-(IBAction)showSearch:(id)sender;

-(IBAction)search:(id)sender;
-(IBAction)showPlaylist:(id)sender;
-(IBAction)minimize:(id)sender;

-(IBAction)gotoCurrentTrack:(id)sender;
-(IBAction)close:(id)sender;
-(IBAction)logout:(id)sender;

@end
