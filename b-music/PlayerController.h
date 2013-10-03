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
-(NSString*)nextTrack;
-(void)bufferingTrack:(double)percentage;
-(void)durationTrack:(double)duration;
-(void) runtimeTrack:(double) seconds;
-(float)volumeTrack;
@end

@interface PlayerController : NSObject

@property (weak) id <PlayerDelegate> delegate;

@property float volume;
@property BOOL repeat;

@property (strong) AVPlayer *player;
@property (strong) AVPlayerItem *playerItem;

-(void)play:(NSString*) URLstring;
@end
