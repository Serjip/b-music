//
//  PlayerController.m
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "PlayerController.h"

@implementation PlayerController

-(void)play:(NSString*) URLstring{
    
    NSURL *URL = [NSURL URLWithString:URLstring];
    
    NSLog(@"Should play %@",URL);
    self.playerItem = [AVPlayerItem playerItemWithURL:URL];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    [self.player setVolume:self.volume];
    //Add buffering observer
    [self.player.currentItem addObserver:self
                              forKeyPath:@"loadedTimeRanges"
                                 options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                                 context:@"loadedTimeRanges"];
    [self.player play];
    [_delegate bufferingTrack:CMTimeGetSeconds([self.player.currentItem duration])];
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
@end
