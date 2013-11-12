//
//  Settings.m
//  b-music
//
//  Created by Sergey P on 27.09.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "Settings.h"
@implementation SettingsC
#define userDefaults @"com.ttitt.settings"//String where is the data located

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        
        /*
         * VK
         */
        _user_id=[coder decodeIntegerForKey:@"user_id"];
        _token=[coder decodeObjectForKey:@"token"];
        _first_name=[coder decodeObjectForKey:@"first_name"];
        _last_name=[coder decodeObjectForKey:@"last_name"];
        _avatar=[coder decodeObjectForKey:@"avatar"];
        
        /*
         * Player
         */
        _repeat = [coder decodeBoolForKey:@"repeat"];
        _shuffle = [coder decodeBoolForKey:@"shuffle"];
        _runTime = [coder decodeBoolForKey:@"runtime"];
        _alwaysOnTop = [coder decodeBoolForKey:@"alwaysOnTop"];
        _volume = [coder decodeFloatForKey:@"volume"];
        
        /*
         * Lastfm
         */
        _nowPlayingTrackLastfm=[coder decodeBoolForKey:@"nowPlayingTrackLastfm"];
        _scrobbleTrackLastfm=[coder decodeBoolForKey:@"scrobbleTrackLastfm"];
        _sessionLastfm=[coder decodeObjectForKey:@"sessionLastfm"];
        _nameLastfm=[coder decodeObjectForKey:@"nameLastfm"];
        
        /*
         *Preferences general
         */
        _showIconMenubar=[coder decodeBoolForKey:@"showIconMenubar"];
        _showArtworkDock=[coder decodeBoolForKey:@"showArtworkDock"];
        _showNotafications=[coder decodeBoolForKey:@"showNotafications"];
        _searchArtwork=[coder decodeBoolForKey:@"searchArtwork"];
        
        
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    /*
     * VK
     */
    [aCoder encodeInteger:_user_id      forKey:@"user_id"];
    [aCoder encodeObject:_token         forKey:@"token"];
    [aCoder encodeObject:_first_name    forKey:@"first_name"];
    [aCoder encodeObject:_last_name     forKey:@"last_name"];
    [aCoder encodeObject:_avatar        forKey:@"avatar"];
    
    /*
     * Player
     */
    [aCoder encodeBool:_repeat      forKey:@"repeat"];
    [aCoder encodeBool:_shuffle     forKey:@"shuffle"];
    [aCoder encodeBool:_runTime     forKey:@"runtime"];
    [aCoder encodeBool:_alwaysOnTop forKey:@"alwaysOnTop"];
    [aCoder encodeFloat:_volume     forKey:@"volume"];
    
    /*
     * Lastfm
     */
    [aCoder encodeBool:_nowPlayingTrackLastfm   forKey:@"nowPlayingTrackLastfm"];
    [aCoder encodeBool:_scrobbleTrackLastfm     forKey:@"scrobbleTrackLastfm"];
    [aCoder encodeObject:_sessionLastfm         forKey:@"sessionLastfm"];
    [aCoder encodeObject:_nameLastfm            forKey:@"nameLastfm"];
    
    /*
     *Preferences general
     */
    [aCoder encodeBool:_showIconMenubar     forKey:@"showIconMenubar"];
    [aCoder encodeBool:_showArtworkDock     forKey:@"showArtworkDock"];
    [aCoder encodeBool:_showNotafications   forKey:@"showNotafications"];
    [aCoder encodeBool:_searchArtwork       forKey:@"searchArtwork"];
}

@end

@implementation Settings


+ (Settings *)sharedInstance {
    static dispatch_once_t pred;
    static Settings *sharedInstance = nil;
    dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [defaults dataForKey:userDefaults];
        
        //[defaults removeObjectForKey:userDefaults];
        if (data) {
            _settings = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        } else {
            NSLog(@"First Launching");
            _settings = [[SettingsC alloc] init];
            /*
             * Preferences player
             */
            _settings.volume=1.0;
            
            /*
             * Preferences general
             */
            _settings.showIconMenubar=YES;
            _settings.showArtworkDock=YES;
            _settings.showNotafications=YES;
            _settings.searchArtwork=YES;
            
            [self saveSettings];
        }
    }
    return self;
}
- (void)saveSettings {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:_settings] forKey:userDefaults];
    [defaults synchronize];
}

-(NSString *)description{
    NSMutableDictionary * list= [[NSMutableDictionary alloc]init];
    
    //VK
    [list setValue:@(self.settings.user_id)    forKey:@"user_id"];
    [list setValue:self.settings.token         forKey:@"token"];
    [list setValue:self.settings.first_name    forKey:@"first_name"];
    [list setValue:self.settings.last_name     forKey:@"last_name"];
    
    //Lastfm
    [list setValue:@(self.settings.nowPlayingTrackLastfm)  forKey:@"nowPlayingTrackLastfm"];
    [list setValue:@(self.settings.scrobbleTrackLastfm)    forKey:@"scrobbleTrackLastfm"];
    [list setValue:self.settings.sessionLastfm             forKey:@"sessionLastfm"];
    [list setValue:self.settings.nameLastfm                forKey:@"nameLastfm"];
    
    //general
    [list setValue:@(self.settings.showIconMenubar)  forKey:@"showIconMenubar"];
    [list setValue:@(self.settings.showArtworkDock)  forKey:@"showArtworkDock"];
    [list setValue:@(self.settings.showNotafications)  forKey:@"showNotafications"];
    [list setValue:@(self.settings.searchArtwork)  forKey:@"searchArtwork"];
    
    //player
    
    [list setValue:@(self.settings.repeat)  forKey:@"repeat"];
    [list setValue:@(self.settings.shuffle)  forKey:@"shuffle"];
    [list setValue:@(self.settings.runTime)  forKey:@"runtime"];
    [list setValue:@(self.settings.alwaysOnTop)  forKey:@"alwaysOnTop"];
    [list setValue:@(self.settings.volume)  forKey:@"volume"];
    
    return [NSString stringWithFormat:@"%@", list];
}

@end
