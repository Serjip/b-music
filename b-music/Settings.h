//
//  Settings.h
//  b-music
//
//  Created by Sergey P on 27.09.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsC : NSObject <NSCoding>

/*
 *  Palyer
 */

@property BOOL repeat;
@property BOOL shuffle;
@property BOOL runTime;
@property BOOL alwaysOnTop;
@property float volume;

/*
 *Preferences general
 */

@property BOOL showIconMenubar;
@property BOOL showArtworkDock;
@property BOOL showNotafications;
@property BOOL searchArtwork;

/*
 *Preferences Lastfm
 */

@property BOOL nowPlayingTrack;
@property BOOL scrobbleTrack;

/*
 *Preferences VK
 */

@property NSInteger user_id;
@property NSString *token;
@property BOOL userOffline;;

@end


@interface Settings : NSObject
@property SettingsC * settings;
-(void) saveSettings;
@end


