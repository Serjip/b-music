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
        _user_id=[coder decodeIntegerForKey:@"user_id"];
        _token=[coder decodeObjectForKey:@"token"];
        
        _repeat = [coder decodeBoolForKey:@"repeat"];
        _shuffle = [coder decodeBoolForKey:@"shuffle"];
        _runTime = [coder decodeBoolForKey:@"runtime"];
        _alwaysOnTop = [coder decodeBoolForKey:@"alwaysOnTop"];
        _volume = [coder decodeFloatForKey:@"volume"];
        
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeInteger:_user_id forKey:@"user_id"];
    [aCoder encodeObject:_token forKey:@"token"];
    
    [aCoder encodeBool:_repeat forKey:@"repeat"];
    [aCoder encodeBool:_shuffle forKey:@"shuffle"];
    [aCoder encodeBool:_runTime forKey:@"runtime"];
    [aCoder encodeBool:_alwaysOnTop forKey:@"alwaysOnTop"];
    [aCoder encodeFloat:_volume forKey:@"volume"];
}
@end

@implementation Settings

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
            _settings.volume=1.0;
            
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
    return [NSString stringWithFormat:@"user_id %ld, token %@, repeat %i, shuffle %i, runtime %i, alwaysOnTop %i, volume %f"
                                        ,self.settings.user_id
                                        ,self.settings.token
                                        ,self.settings.repeat
                                        ,self.settings.shuffle
                                        ,self.settings.runTime
                                        ,self.settings.alwaysOnTop
                                        ,self.settings.volume];
}

@end
