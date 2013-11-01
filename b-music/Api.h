//
//  Api.h
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Api : NSObject

-(id) requestAPI:(NSString*)method parametesForMethod:(NSString*)param token:(NSString*)token;

-(void) auth;

-(NSMutableDictionary *) parseAccessTokenAndUserIdFormString:(NSString*)stringURL;

-(BOOL) checkForErrorResponse:(id)response;

-(BOOL) requestAPIVkRemoveTrack:(NSString*)token owner_id:(NSString*)owner_id  idTrack:(NSString*)idTrack;//Remove Track

-(BOOL) requestAPIVkAddTrack:(NSString*)token owner_id:(NSString *)owner_id idTrack:(NSString *) idTrack;//Add track

-(id) requestAPIVkSearch:(NSString*)token searchQuery:(NSString *)searchQuery; //Search

-(id) requestAPIVkLoadMainplaylist:(NSString*)token; // Main playlist

@end
