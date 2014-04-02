//
//  LastfmAPI.m
//  b-music
//
//  Created by Sergey P on 24.10.13.
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

#import "LastfmAPI.h"
#import <CommonCrypto/CommonCrypto.h>
#import "Settings.h"

#define API_URL @"http://ws.audioscrobbler.com/2.0/"
#define API_KEY @"2eae06b8e133096849f10006f4da696a"
#define SECRET  @"ad9e320f7137cff7666348ef5a447c97"
#define AuthURL @"http://www.last.fm/api/auth/?api_key="

@implementation LastfmAPI{
    NSString * _token;
}

-(id)requestAPILastfmWithParams:(NSMutableDictionary*)params{
    
    [params setValue:@"json" forKey:@"format"];
    
    NSString * stringParam=@"";
    for (NSString * key in params) {
        NSString * value = [params objectForKey:key];
        
        stringParam=[stringParam stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,value]];
    }
    
    stringParam=[stringParam substringToIndex:stringParam.length-1];//Removing last amp
    stringParam=[stringParam stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // Do we need to POST or GET?
    BOOL doPost = YES;
    NSString * method = [params objectForKey:@"method"];
    
    NSArray *methodParts = [method componentsSeparatedByString:@"."];
    if ([methodParts count] > 1) {
        NSString *secondPart = [methodParts objectAtIndex:1];
        if ([secondPart hasPrefix:@"get"]) {
            doPost = NO;
        }
    }
    
    NSMutableURLRequest *request;
    if (doPost) {
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:API_URL]];
        request.timeoutInterval = 10;
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[stringParam dataUsingEncoding:NSUTF8StringEncoding]];
    } else {
        NSString *urlString = [NSString stringWithFormat:@"%@?%@", API_URL, stringParam];
        
        NSURLRequestCachePolicy policy = NSURLRequestUseProtocolCachePolicy;
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:policy timeoutInterval:10];
    }
    
    NSHTTPURLResponse *response;
    NSError *error;
    NSData *returnedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    id object = [NSJSONSerialization
                 JSONObjectWithData:returnedData
                 options:0
                 error:&error];
    if (error) { /* JSON was malformed, act appropriately here */ }
    return object;
}

-(id)track_getInfo:(NSString *) artist
             track:(NSString *)track{
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
    
    [params setValue:@"track.getInfo"  forKey:@"method"];
    [params setValue:@"1"              forKey:@"autocorrect"];
    [params setValue:artist            forKey:@"artist"];
    [params setValue:track             forKey:@"track"];
    [params setValue:API_KEY           forKey:@"api_key"];
    
    id obj = [self requestAPILastfmWithParams:params];
    return obj;
}

-( NSImage * )getImageWithArtist:(NSString *)artist
                           track:(NSString *)track
                            size:(NSInteger)size {
    
    id obj=[self track_getInfo:artist track:track];
    id imageObj = [[[obj objectForKey:@"track"] objectForKey:@"album"] objectForKey:@"image"];
    NSString * stringImageURL = [[imageObj objectAtIndex:size]objectForKey:@"#text"];
    NSLog(@"%@",stringImageURL);
    return [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:stringImageURL]];
}

-(void) authorize{
    NSString * stringURL=[NSString stringWithFormat:@"%@%@",AuthURL,API_KEY];
    [NSWorkspace.sharedWorkspace openURL:[NSURL URLWithString:stringURL]];
}

-(void) unAuthorize{
    Settings.sharedInstance.settings.sessionLastfm=nil;
    Settings.sharedInstance.settings.nameLastfm=nil;
    [Settings.sharedInstance saveSettings];
}


-(id)auth_getSession:(NSString *)token {
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
    [params setValue:@"auth.getSession"  forKey:@"method"];
    [params setValue:API_KEY           forKey:@"api_key"];
    [params setValue:token           forKey:@"token"];

    NSString * api_sig=[self api_sigWithParams:params];
    [params setValue:api_sig forKey:@"api_sig"];
    
    id obj = [self requestAPILastfmWithParams:params];
    return obj;
}

-(void) track_updateNowPlaying:(NSString *)artist
                         track:(NSString*)track
                      duration:(NSString*)duration {
    
    BOOL nowPlaying = Settings.sharedInstance.settings.nowPlayingTrackLastfm;
    if(!nowPlaying) return;//Check avalible
    
    NSString * session = Settings.sharedInstance.settings.sessionLastfm;
    
    if (!session || session.length==0) return ;
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
    [params setValue:@"track.updateNowPlaying" forKey:@"method"];
    [params setValue:artist                    forKey:@"artist"];
    [params setValue:track                     forKey:@"track"];
    [params setValue:duration                  forKey:@"duration"];
    [params setValue:API_KEY                   forKey:@"api_key"];
    [params setValue:session                   forKey:@"sk"];
    
    NSString * api_sig=[self api_sigWithParams:params];
    [params setValue:api_sig forKey:@"api_sig"];
    
    id obj = [self requestAPILastfmWithParams:params];
    
    NSLog(@"Lastfm response %@",obj);
}

-(void) track_scrobble:(NSString *)artist
                 track:(NSString *)track{
    
    BOOL scrobble = Settings.sharedInstance.settings.scrobbleTrackLastfm;
    if(!scrobble) return;//Check avalible
    
    NSString * session = Settings.sharedInstance.settings.sessionLastfm;
    
    if (!session || session.length==0) return ;
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
    [params setValue:@"track.scrobble"                             forKey:@"method"];
    [params setValue:artist                                        forKey:@"artist"];
    [params setValue:track                                         forKey:@"track"];
    [params setValue:@((int)[[NSDate date] timeIntervalSince1970]) forKey:@"timestamp"];
    [params setValue:API_KEY                                       forKey:@"api_key"];
    [params setValue:session                                       forKey:@"sk"];
    
    NSString * api_sig=[self api_sigWithParams:params];
    [params setValue:api_sig forKey:@"api_sig"];
    
    id obj = [self requestAPILastfmWithParams:params];
    NSLog(@"Lastfm response %@",obj);
}

-(void)parseTokenUsernameFormString:(NSString *)tokenStr{
    tokenStr =[tokenStr substringFromIndex:1];
    NSArray *components = [tokenStr componentsSeparatedByString:@"="];
    
    if (![[components objectAtIndex:0] isEqual:@"token"])
        return;
    
    id obj=[self auth_getSession:[components objectAtIndex:1]];
    id sessionObj=[obj objectForKey:@"session"];
    
    NSString * key= [sessionObj objectForKey:@"key"];
    NSString * name= [sessionObj objectForKey:@"name"];
    
    if (!key || !name) return;
    
    Settings.sharedInstance.settings.nameLastfm=name;
    Settings.sharedInstance.settings.sessionLastfm=key;
    [Settings.sharedInstance saveSettings];
    
    [self.delegate finishAuthorizeLastfm];
}

#pragma mark Private methods

-(NSString*)api_sigWithParams:(NSMutableDictionary *) params{
    NSArray * sortedKeys = [[params allKeys] sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];
    NSString *str=@"";
    for (NSString * key in sortedKeys) {
         NSString * value = [params objectForKey:key];
        str=[str stringByAppendingString:[NSString stringWithFormat:@"%@%@",key,value]];
    }
    str=[str stringByAppendingString:SECRET];
    return [self md5sumFromString:str];
}
- (NSString *)md5sumFromString:(NSString *)string {
	unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
	CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
	NSMutableString *ms = [NSMutableString string];
	for (i=0;i<CC_MD5_DIGEST_LENGTH;i++) {
		[ms appendFormat: @"%02x", (int)(digest[i])];
	}
	return [ms copy];
}

@end
