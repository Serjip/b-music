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
-(void) beginAuthVK;
@end


@interface vkAPI : NSObject

@property (weak) id <vkAPIDelegate> delegate;


-(BOOL) checkForErrorResponse:(id)response;

/*
 *  API METHODS
 ******************/
-(id) audio_get;
-(BOOL) audio_deleteWithOwner_id:(NSString *)owner_id
                       idTrack:(NSString *)idTrack;

-(BOOL) audio_addWithOwner_id:(NSString *)owner_id
                    idTrack:(NSString *)idTrack;

-(id) audio_searchWithSearchQuery:(NSString *)searchQuery;
-(id) users_get;
/*
 *  Auth Methods
 ******************/
-(void) parseAccessTokenAndUserIdFormString:(NSString *)tokenStr;

-(void)login;
-(void)logout;
-(void)signup;
@end
