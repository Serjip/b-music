//
//  PlayerController.m
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "PlayerController.h"

@implementation PlayerController{
    NSTimer * _timerObserverIndicator;
}

-(void)play:(NSString*) URLstring{
    if(_timerObserverIndicator){
        
        [self.player removeObserver:self forKeyPath:@"rate"];
        [self.player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        
        [_timerObserverIndicator invalidate];
        _timerObserverIndicator=nil;
    }
    
    self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:URLstring]];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    [self.player setVolume:[_delegate getVolume]];
    //Add observer to next song
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(nextTrack:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[self.player currentItem]];
    //Add buffering observer
    [self.player.currentItem addObserver:self
                              forKeyPath:@"loadedTimeRanges"
                                 options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                                 context:@"loadedTimeRanges"];
    
    //Add player state observer
    [self.player addObserver:self
                  forKeyPath:@"rate"
                     options:NSKeyValueObservingOptionNew
                     context:@"rate"];
    
    _timerObserverIndicator=[NSTimer scheduledTimerWithTimeInterval:0.1
                                                             target:self
                                                           selector:@selector(currentRuntime:)
                                                           userInfo:nil
                                                            repeats:YES];
    [self.player play];
    
    [_delegate durationTrack:CMTimeGetSeconds([self.player.currentItem.asset duration])];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if (context==@"loadedTimeRanges") {
        
        CMTimeRange timeRange = [[[object loadedTimeRanges] objectAtIndex:0] CMTimeRangeValue];
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        
        NSTimeInterval result = startSeconds + durationSeconds;
        if(isnan(result)) result=0;
        [_delegate bufferingTrack:result/ CMTimeGetSeconds([self.player.currentItem.asset duration])];
    
    }else if (context == @"rate") {
        [_delegate isPlayerPlaying:[object rate]];
    }
}


- (void)nextTrack:(NSNotification *)notification
{
    if([_delegate getRepeat]){
        [self.player seekToTime:kCMTimeZero];
        [self.player play];
    }else{
        [_delegate nextTrack];
    }
}

-(void)setRuntime:(double)currentTime{
    NSString *str;
    if ([_delegate getRuntime]) {
        str=[NSString stringWithFormat:@"-%@",[self convertTime:CMTimeGetSeconds([self.player.currentItem.asset duration])-currentTime]];
    }else{
        str=[self convertTime:currentTime];
    }
    [_delegate runtimeTrack:currentTime secondsString:str];
    [self.player seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC)];
}
-(void) currentRuntime:(NSTimer *)timer{
    double currentTime=CMTimeGetSeconds(self.player.currentTime);
    NSString *str;
    
    if ([_delegate getRuntime]) {
        str=[NSString stringWithFormat:@"-%@",[self convertTime:CMTimeGetSeconds([self.player.currentItem.asset duration])-currentTime]];
    }else{
        str=[self convertTime:currentTime];
    }
    [_delegate runtimeTrack:currentTime secondsString:str];
}

-(NSString*)convertTime:(double)seconds {
    int secs = seconds;
    int m = secs / 60;
    int s = secs % 60;
    return  [NSString stringWithFormat:@"%d:%02i",m, s];
}

- (NSMutableArray*)generateShufflePlaylist:(NSMutableArray*)playlist
{
    if (!playlist) return nil;
    NSMutableArray * arr=[playlist mutableCopy];
    NSUInteger count = [arr count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSInteger nElements = count - i;
        NSInteger n = (arc4random() % nElements) + i;
        [arr exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    return arr;
}

@end
