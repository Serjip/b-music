//
//  LastfmAPI.h
//  b-music
//
//  Created by Sergey P on 24.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LastfmAPI : NSObject

@property (strong)  NSString * session;




-(NSImage*)getImageWithArtist:(NSString *) artist track:(NSString *)track size:(NSInteger)size;
-(void) authorize;



#pragma mark Last.fm Methods
-(id)auth_getSession:(NSString *)token;
-(id)track_getInfo:(NSString *) artist track:(NSString *)track;
-(id) track_updateNowPlaying:(NSString *)artist track:(NSString*)track duration:(NSString*)duration;

@end
