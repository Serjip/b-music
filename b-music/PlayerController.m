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
    
    NSURL *URL = [NSURL URLWithString:URLstring];
    
    NSLog(@"Should play %@",URL);
    self.playerItem = [AVPlayerItem playerItemWithURL:URL];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    [self.player setVolume:[_delegate getVolume]];
    //Add buffering observer
    [self.player.currentItem addObserver:self
                              forKeyPath:@"loadedTimeRanges"
                                 options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                                 context:@"loadedTimeRanges"];
    _timerObserverIndicator=[NSTimer scheduledTimerWithTimeInterval:1.0
                                                             target:self
                                                           selector:@selector(currentRuntime:)
                                                           userInfo:nil
                                                            repeats:YES];
    [self.player play];
    [_delegate durationTrack:CMTimeGetSeconds([self.player.currentItem duration])];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if (context==@"loadedTimeRanges") {
        
        CMTimeRange timeRange = [[[object loadedTimeRanges] objectAtIndex:0] CMTimeRangeValue];
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        
        NSTimeInterval result = startSeconds + durationSeconds;
        if(!result) result=0;
        [_delegate bufferingTrack:result/ CMTimeGetSeconds([self.player.currentItem duration])];
    
    }else if (1!=1){
        
    }
}
-(void)setRuntime:(double)currentTime{
    NSString *str;
    
    if ([_delegate getRuntime]) {
        str=[NSString stringWithFormat:@"-%@",[self convertTime:CMTimeGetSeconds([self.player.currentItem duration])-currentTime]];
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
        str=[NSString stringWithFormat:@"-%@",[self convertTime:CMTimeGetSeconds([self.player.currentItem duration])-currentTime]];
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

@end
