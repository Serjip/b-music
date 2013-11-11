//
//  vkAPI.h
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Settings.h"

@protocol vkAPIDelegate <NSObject>
-(void) finishAuthVK;
@end


@interface vkAPI : NSObject

@property (weak) id <vkAPIDelegate> delegate;

-(void) parseAccessTokenAndUserIdFormString:(NSString *)tokenStr;

-(BOOL) checkForErrorResponse:(id)response;

-(BOOL) requestAPIVkRemoveTrackWithOwner_id:(NSString *)owner_id
                        idTrack:(NSString *)idTrack;//Remove Track

-(BOOL) requestAPIVkAddTrackWithOwner_id:(NSString *)owner_id
                     idTrack:(NSString *)idTrack;//Add track

-(id) requestAPIVkSearchWithSearchQ:(NSString *)searchQuery; //Search

-(id) requestAPIVkLoadMainplaylist; // Main playlist

//Set accaunt offline
-(BOOL) account_setOffline;

-(void)login;
-(void)logout;
-(void)signup;
@end
