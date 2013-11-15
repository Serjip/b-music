//
//  vkAPI.m
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "vkAPI.h"

#define kAuthURL @"https://oauth.vk.com/authorize?client_id=3796579&scope=audio,offline&redirect_uri=http://ttitt.ru/auth/&v=5.2&response_type=token"
#define API_URL @"https://api.vk.com/method/"
@implementation vkAPI

-(id) requestVKAPI:(NSString*)method
            params:(NSMutableDictionary *)params{
    
    NSString * stringParam=@"";
    for (NSString * key in params) {
        NSString * value = [params objectForKey:key];
        stringParam=[stringParam stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",key,value]];
    }
    stringParam=[stringParam substringFromIndex:1];
    NSString *stringURL=[NSString stringWithFormat:@"%@%@?%@", API_URL, method,stringParam];
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

/*
 * API Methods
 **************************/


-(id) audio_get{
    
    NSString * token = Settings.sharedInstance.settings.token;
    if (!token) [self logout];
    NSString * method=@"audio.get";
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setValue:token forKey:@"access_token"];
    [params setValue:@"5.2" forKey:@"v"];
    
    id response = [self requestVKAPI:method
                              params:params];
    
    return response;
}

-(BOOL) audio_deleteWithOwner_id:(NSString *)owner_id
                       idTrack:(NSString *)idTrack {
    
    NSString * token = Settings.sharedInstance.settings.token;
    if (!token) [self logout];
    NSString * method=@"audio.delete";
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setValue:token      forKey:@"access_token"];
    [params setValue:@"5.2"     forKey:@"v"];
    [params setValue:owner_id   forKey:@"owner_id"];
    [params setValue:idTrack   forKey:@"audio_id"];
    
    id response = [self requestVKAPI:method
                              params:params];
    return [self checkForErrorResponse:response];
}

-(BOOL) audio_addWithOwner_id:(NSString *)owner_id
                       idTrack:(NSString *)idTrack {
    
    NSString * token = Settings.sharedInstance.settings.token;
    if (!token) [self logout];
    
    NSString * method=@"audio.add";
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setValue:token      forKey:@"access_token"];
    [params setValue:@"5.2"     forKey:@"v"];
    [params setValue:owner_id   forKey:@"owner_id"];
    [params setValue:idTrack   forKey:@"audio_id"];
    
    id response = [self requestVKAPI:method
                              params:params];
    
    return [self checkForErrorResponse:response];
}

-(id) audio_searchWithSearchQuery:(NSString *)searchQuery {
    
    NSString * token = Settings.sharedInstance.settings.token;
    if (!token) [self logout];
    
    NSString * method=@"audio.search";
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setValue:token          forKey:@"access_token"];
    [params setValue:@"5.2"         forKey:@"v"];
    [params setValue:searchQuery    forKey:@"q"];
    [params setValue:@"1"           forKey:@"auto_complete"];
    [params setValue:@"2"           forKey:@"sort"];
    [params setValue:@"150"           forKey:@"count"];
    
    id response = [self requestVKAPI:method
                              params:params];
    return response;
}


-(id) users_get{
    
    NSInteger user_id= Settings.sharedInstance.settings.user_id;
    if (!user_id) [self logout];
    
    NSString * method=@"users.get";
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setValue:@"5.3"         forKey:@"v"];
    [params setValue:@(user_id)     forKey:@"user_ids"];
    [params setValue:@"photo_100"   forKey:@"fields"];
    
    id response = [self requestVKAPI:method
                              params:params];
    return response;
}


-(BOOL) checkForErrorResponse:(id)response{
    
    if ([response objectForKey:@"error"]) {
        
        if ([[[response objectForKey:@"error"] objectForKey:@"error_code"] isEqual:@(17)]) {
            
            //Open error in browser
            [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:[[response objectForKey:@"error"] objectForKey:@"redirect_uri"]]];
            NSLog(@"%@",response);
        }
        
        return NO;//Error
    }
    
    return YES;//Success
}

/*
 * AUTHORIZATION
 ****************/

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

-(void) parseAccessTokenAndUserIdFormString:(NSString *)tokenStr{
    
    NSMutableDictionary *tokenDic=[self parseStringURL:tokenStr];
    
    if (![tokenDic objectForKey:@"access_token"])
        return;
    
    if (![tokenDic objectForKey:@"user_id"])
        return;
    
    Settings.sharedInstance.settings.token=[tokenDic objectForKey:@"access_token"];
    Settings.sharedInstance.settings.user_id=[[tokenDic objectForKey:@"user_id"] integerValue];
    Settings.sharedInstance.settings.timerNonPurchase=[[NSDate date] timeIntervalSince1970];
    [Settings.sharedInstance saveSettings];
    
    id rsp = [[self users_get] objectForKey:@"response"];
    NSString * first_name = [[rsp objectAtIndex:0] objectForKey:@"first_name"];
    NSString * last_name = [[rsp objectAtIndex:0] objectForKey:@"last_name"];
    NSString * avatarStrURL = [[rsp objectAtIndex:0] objectForKey:@"photo_100"];
    NSImage * avatar = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:avatarStrURL]];
    
    Settings.sharedInstance.settings.first_name= first_name;
    Settings.sharedInstance.settings.last_name= last_name;
    Settings.sharedInstance.settings.avatar= avatar;
    
    [Settings.sharedInstance saveSettings];
    
    [self.delegate finishAuthVK];
}


-(void)logout{ NSLog(@"Logut");
    Settings.sharedInstance.settings.token=nil;//Remove token
    Settings.sharedInstance.settings.user_id=0;//Remove userid
    Settings.sharedInstance.settings.first_name=nil;
    Settings.sharedInstance.settings.last_name=nil;
    Settings.sharedInstance.settings.avatar=nil;
    Settings.sharedInstance.settings.timerNonPurchase=[[NSDate date] timeIntervalSince1970];//For non update logout
    
    [Settings.sharedInstance saveSettings];
    
    [self.delegate beginAuthVK];
}
-(void)login{ NSLog(@"Login");
    [NSWorkspace.sharedWorkspace openURL:[NSURL URLWithString:kAuthURL]];
}

-(void)signup{ NSLog(@"Singup");
    [NSWorkspace.sharedWorkspace openURL:[NSURL URLWithString:@"http://vk.com/"]];
}
@end
