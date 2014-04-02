//
//  vkAPI.h
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
