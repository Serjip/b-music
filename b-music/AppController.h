//
//  AppController.h
//  b-music
//
//  Created by Sergey P on 01.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SheetWindowController.h"
@interface AppController : NSObject<SheetDelegate>
@property SheetWindowController * sheet;

@property (weak) IBOutlet NSView *Controls0;
@property (weak) IBOutlet NSView *Controls1;
@property (weak) IBOutlet NSView *Controls2;
@property (weak) IBOutlet NSView *Controls3;

@property (weak) IBOutlet NSView *BottomControls0;
@property (weak) IBOutlet NSView *BottomControls1;


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
-(IBAction)addTrack:(id)sender;
-(IBAction)removeTrack:(id)sender;
-(IBAction)volume:(id)sender;
-(IBAction)runtime:(id)sender;
-(IBAction)showSearch:(id)sender;
-(IBAction)hideSearch:(id)sender;
-(IBAction)search:(id)sender;
-(IBAction)logout:(id)sender;

@end
