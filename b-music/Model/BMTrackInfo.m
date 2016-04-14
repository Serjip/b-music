//
//  BMTrackInfo.m
//  b-music
//
//  Created by Sergey P on 14.04.16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

#import "BMTrackInfo.h"

@implementation BMTrackInfo

- (instancetype)initWithServerResponse:(NSDictionary *)response
{
    self = [super init];
    if (self)
    {
        NSString *trackURLString = [response objectForKey:@"trackViewUrl"];
        if ([trackURLString isKindOfClass:[NSString class]])
        {
            trackURLString = [trackURLString stringByAppendingString:@"&at=1l3v3II&ct=bmusic"];
            _trackURL = [NSURL URLWithString:trackURLString];
        }
        
        NSString *trackName = [response objectForKey:@"trackName"];
        if ([trackName isKindOfClass:[NSString class]])
        {
            _trackName = trackName;
        }
        
        NSString *artist = [response objectForKey:@"artistName"];
        if ([artist isKindOfClass:[NSString class]])
        {
            _artist = artist;
        }
        
        NSString *artwork = [response objectForKey:@"artworkUrl100"];
        if ([artwork isKindOfClass:[NSString class]])
        {
            _artworkURLString = artwork;
        }
    }
    return self;
}
@end
