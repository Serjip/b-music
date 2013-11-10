//
//  vkAPI.h
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol vkAPIDelegate <NSObject>
-(void) finishAuth:(NSString *)token
           user_id:(NSInteger)user_id;
@end


@interface vkAPI : NSObject

@property (weak) id <vkAPIDelegate> delegate;
@property (weak) NSAlert * alert;

//Start auth
-(void) auth;

-(void) parseAccessTokenAndUserIdFormString:(NSString *)tokenStr;

-(BOOL) checkForErrorResponse:(id)response;

-(BOOL) requestAPIVkRemoveTrack:(NSString *)token
                       owner_id:(NSString *)owner_id
                        idTrack:(NSString *)idTrack;//Remove Track

-(BOOL) requestAPIVkAddTrack:(NSString *)token
                    owner_id:(NSString *)owner_id
                     idTrack:(NSString *)idTrack;//Add track

-(id) requestAPIVkSearch:(NSString *)token
             searchQuery:(NSString *)searchQuery; //Search

-(id) requestAPIVkLoadMainplaylist:(NSString*)token; // Main playlist

//Set accaunt offline
-(BOOL) account_setOffline:(NSString *)token ;

@end
