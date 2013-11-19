//
//  Settings.m
//  b-music
//
//  Created by Sergey P on 27.09.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "Settings.h"
@implementation SettingsC

#define userDefaults @"com.ttitt.b-music.settings"//String where is the data located

#define secret @"dba24bcca55ca43fa5704c679f98b991"

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        /*
         * Purchase
         */
        _timerNonPurchase= [coder decodeDoubleForKey:[@"timerNonPurchase" stringByAppendingString:secret]];
        _purchased = [coder decodeBoolForKey:[@"purchased" stringByAppendingString:secret]];
        
        /*
         * VK
         */
        _user_id=[coder decodeIntegerForKey:[@"user_id" stringByAppendingString:secret]];
        _token=[coder decodeObjectForKey:[@"token" stringByAppendingString:secret]];
        _first_name=[coder decodeObjectForKey:[@"first_name" stringByAppendingString:secret]];
        _last_name=[coder decodeObjectForKey:[@"last_name" stringByAppendingString:secret]];
        _avatar=[coder decodeObjectForKey:[@"avatar" stringByAppendingString:secret]];
        
        /*
         * Player
         */
        _repeat = [coder decodeBoolForKey:[@"repeat" stringByAppendingString:secret]];
        _shuffle = [coder decodeBoolForKey:[@"shuffle" stringByAppendingString:secret]];
        _runTime = [coder decodeBoolForKey:[@"runtime" stringByAppendingString:secret]];
        _alwaysOnTop = [coder decodeBoolForKey:[@"alwaysOnTop" stringByAppendingString:secret]];
        _volume = [coder decodeFloatForKey:[@"volume" stringByAppendingString:secret]];
        
        /*
         * Lastfm
         */
        _nowPlayingTrackLastfm=[coder decodeBoolForKey:[@"nowPlayingTrackLastfm" stringByAppendingString:secret]];
        _scrobbleTrackLastfm=[coder decodeBoolForKey:[@"scrobbleTrackLastfm" stringByAppendingString:secret]];
        _sessionLastfm=[coder decodeObjectForKey:[@"sessionLastfm" stringByAppendingString:secret]];
        _nameLastfm=[coder decodeObjectForKey:[@"nameLastfm" stringByAppendingString:secret]];
        
        /*
         *Preferences general
         */
        _showIconMenubar=[coder decodeBoolForKey:[@"showIconMenubar" stringByAppendingString:secret]];
        _showArtworkDock=[coder decodeBoolForKey:[@"showArtworkDock" stringByAppendingString:secret]];
        _showNotafications=[coder decodeBoolForKey:[@"showNotafications" stringByAppendingString:secret]];
        _searchArtwork=[coder decodeBoolForKey:[@"searchArtwork" stringByAppendingString:secret]];
        
        
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    /*
     * Purchase
     */
    [aCoder encodeDouble:_timerNonPurchase forKey:[@"timerNonPurchase"  stringByAppendingString:secret]];
    [aCoder encodeBool:_purchased forKey:[@"purchased"  stringByAppendingString:secret]];
    
    /*
     * VK
     */
    [aCoder encodeInteger:_user_id      forKey:[@"user_id"  stringByAppendingString:secret]];
    [aCoder encodeObject:_token         forKey:[@"token"  stringByAppendingString:secret]];
    [aCoder encodeObject:_first_name    forKey:[@"first_name"  stringByAppendingString:secret]];
    [aCoder encodeObject:_last_name     forKey:[@"last_name"  stringByAppendingString:secret]];
    [aCoder encodeObject:_avatar        forKey:[@"avatar"  stringByAppendingString:secret]];
    
    /*
     * Player
     */
    [aCoder encodeBool:_repeat      forKey:[@"repeat"  stringByAppendingString:secret]];
    [aCoder encodeBool:_shuffle     forKey:[@"shuffle"  stringByAppendingString:secret]];
    [aCoder encodeBool:_runTime     forKey:[@"runtime"  stringByAppendingString:secret]];
    [aCoder encodeBool:_alwaysOnTop forKey:[@"alwaysOnTop"  stringByAppendingString:secret]];
    [aCoder encodeFloat:_volume     forKey:[@"volume"  stringByAppendingString:secret]];
    
    /*
     * Lastfm
     */
    [aCoder encodeBool:_nowPlayingTrackLastfm   forKey:[@"nowPlayingTrackLastfm"  stringByAppendingString:secret]];
    [aCoder encodeBool:_scrobbleTrackLastfm     forKey:[@"scrobbleTrackLastfm"  stringByAppendingString:secret]];
    [aCoder encodeObject:_sessionLastfm         forKey:[@"sessionLastfm"  stringByAppendingString:secret]];
    [aCoder encodeObject:_nameLastfm            forKey:[@"nameLastfm"  stringByAppendingString:secret]];
    
    /*
     *Preferences general
     */
    [aCoder encodeBool:_showIconMenubar     forKey:[@"showIconMenubar"  stringByAppendingString:secret]];
    [aCoder encodeBool:_showArtworkDock     forKey:[@"showArtworkDock"  stringByAppendingString:secret]];
    [aCoder encodeBool:_showNotafications   forKey:[@"showNotafications"  stringByAppendingString:secret]];
    [aCoder encodeBool:_searchArtwork       forKey:[@"searchArtwork"  stringByAppendingString:secret]];
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
    
    //Purchase
    [list setValue:@(self.settings.timerNonPurchase)    forKey:@"TimerPurchase"];
    [list setValue:@(self.settings.purchased)         forKey:@"IsPurchased"];
    
    
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
    [list setValue:@(self.settings.showIconMenubar)     forKey:@"showIconMenubar"];
    [list setValue:@(self.settings.showArtworkDock)     forKey:@"showArtworkDock"];
    [list setValue:@(self.settings.showNotafications)   forKey:@"showNotafications"];
    [list setValue:@(self.settings.searchArtwork)       forKey:@"searchArtwork"];
    
    //player
    [list setValue:@(self.settings.repeat)      forKey:@"repeat"];
    [list setValue:@(self.settings.shuffle)     forKey:@"shuffle"];
    [list setValue:@(self.settings.runTime)     forKey:@"runtime"];
    [list setValue:@(self.settings.alwaysOnTop) forKey:@"alwaysOnTop"];
    [list setValue:@(self.settings.volume)      forKey:@"volume"];
    
    return [NSString stringWithFormat:@"%@", list];
}

@end
