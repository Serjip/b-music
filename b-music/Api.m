//
//  Api.m
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "Api.h"

//#define kAuthURL @"https://oauth.vk.com/authorize?client_id=3796579&scope=audio,offline&redirect_uri=https://oauth.vk.com/blank.html&display=wap&v=5.2&response_type=token"
#define kAuthURL @"https://oauth.vk.com/authorize?client_id=3796579&scope=audio,offline&redirect_uri=http://ttitt.ru/auth/&v=5.2&response_type=token"

@implementation Api


-(id) requestAPI:(NSString*)method parametesForMethod:(NSString*)param token:(NSString*)token {
    
    NSString *stringURL=[NSString stringWithFormat:@"https://api.vk.com/method/%@?%@access_token=%@", method,param,token];
    stringURL=[stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [[NSURL alloc] initWithString:stringURL];
    NSData *returnedData = [[NSData alloc] initWithContentsOfURL:url];
    NSError *error = nil;
    id object = [NSJSONSerialization
                 JSONObjectWithData:returnedData
                 options:0
                 error:&error];
    if(error) { /* JSON was malformed, act appropriately here */ }
    return object;
}

-(void) auth{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:kAuthURL]];
}



-(NSMutableDictionary *) parseAccessTokenAndUserIdFormString:(NSString*)stringURL{
    
    
    NSInteger index = [@"com.ttitt.b-music://" length];
    NSString * tokenString=[stringURL substringFromIndex:index];
    NSMutableDictionary *tokenDict=[self parseStringURL:tokenString];
    
    
    if (![tokenDict objectForKey:@"access_token"]) {
        
        return nil;
    }
    
    if (![tokenDict objectForKey:@"user_id"]) {
        
        return nil;
    }
    
    
    return tokenDict;
}

-(NSMutableDictionary *) parseStringURL:(NSString*)str{
    NSMutableDictionary *queryStringDictionary = [[NSMutableDictionary alloc] init];
    NSArray *urlComponents = [str componentsSeparatedByString:@"&"];
    for (NSString *keyValuePair in urlComponents)
    {
        NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
        NSString *key = [pairComponents objectAtIndex:0];
        NSString *value = [pairComponents objectAtIndex:1];
        [queryStringDictionary setObject:value forKey:key];
    }
    return queryStringDictionary;
}

-(BOOL) checkForErrorResponse:(id)response{
    
    if ([response objectForKey:@"error"]) {
        
        if ([[[response objectForKey:@"error"] objectForKey:@"error_code"] isEqual:@(17)]) {
            
            //Open error in browser
            [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:[[response objectForKey:@"error"] objectForKey:@"redirect_uri"]]];
        }
        
        return NO;//Error
    }
    
    return YES;//Success
}


-(BOOL) requestAPIVkRemoveTrack:(NSString*)token owner_id:(NSString*)owner_id  idTrack:(NSString*)idTrack{
    
    NSString * q = [NSString stringWithFormat:@"&owner_id=%@&audio_id=%@&v=5.2&", owner_id ,idTrack];
    
    id response=[self requestAPI:@"audio.delete" parametesForMethod:q token:token];
    
    return [self checkForErrorResponse:response];
}


-(BOOL) requestAPIVkAddTrack:(NSString*)token owner_id:(NSString *)owner_id idTrack:(NSString *) idTrack {
    
    NSString * q = [NSString stringWithFormat:@"&owner_id=%@&audio_id=%@&v=5.2&", owner_id , idTrack];
    
    id response=[self requestAPI:@"audio.add" parametesForMethod:q token:token];
    
    return [self checkForErrorResponse:response];
}


-(id) requestAPIVkSearch:(NSString*)token searchQuery:(NSString *)searchQuery {
    
    NSString * q = [NSString stringWithFormat:@"&q=%@&auto_complete=1&sort=2&count=150&v=5.2&",searchQuery];
    
    id response=[self requestAPI:@"audio.search" parametesForMethod:q token:token];
    
    return response;
}


-(id) requestAPIVkLoadMainplaylist:(NSString*)token {
    
    if (token==nil) {
        [self auth];//Check tokeb if doesn't exist auth
        return nil;
    }
    
    id response=[self requestAPI:@"audio.get" parametesForMethod:@"&v=5.2&" token:token];
    
    return response;
}

@end
