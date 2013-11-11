//
//  PlayerController.h
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>

@protocol PlayerDelegate <NSObject>

-(void) bufferingTrack:(double)percentage;
-(void) durationTrack:(double)duration;

-(void) runtimeTrack:(double)seconds
       secondsString:(NSString *)str
            scrobble:(BOOL)scrobble;

-(void) isPlayerPlaying:(BOOL)flag;
-(void)nextTrack;

@end

@interface PlayerController : NSObject

@property (weak) id <PlayerDelegate> delegate;

@property float volume;
@property BOOL repeat;
@property double duration;

@property (strong) AVPlayer *player;
@property (strong) AVPlayerItem *playerItem;

-(void)play:(NSString*) URLstring;
-(void)setRuntime:(double)time;
-(NSString*)convertTime:(double)seconds;
- (NSMutableArray*)generateShufflePlaylist:(NSMutableArray*)playlist;
@end
