//
//  PlayerController.h
//  b-music
//
//  Created by Sergey P on 02.10.13.
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
-(void) play;
-(void) pause;
-(void)setRuntime:(double)time;
-(NSString*)convertTime:(double)seconds;
- (NSMutableArray*)generateShufflePlaylist:(NSMutableArray*)playlist;
@end
