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
 * Purchase
 */
@property double timerNonPurchase;
@property BOOL isPurchased;

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

@property BOOL nowPlayingTrackLastfm;
@property BOOL scrobbleTrackLastfm;
@property NSString *sessionLastfm;
@property NSString *nameLastfm;

/*
 *Preferences VK
 */

@property NSInteger user_id;
@property NSString *token;
@property NSString *first_name;
@property NSString *last_name;
@property NSImage *avatar;

@end


@interface Settings : NSObject
@property SettingsC * settings;
+ (Settings *)sharedInstance;
-(void) saveSettings;
@end


