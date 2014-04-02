//
//  AppController.h
//  b-music
//
//  Created by Sergey P on 01.10.13.
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

#import <Foundation/Foundation.h>
#import "SPMediaKeyTap.h"

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
@property SPMediaKeyTap * keyTap;

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
