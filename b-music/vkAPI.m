//
//  vkAPI.m
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "vkAPI.h"

#define kAuthURL @"https://oauth.vk.com/authorize?client_id=3796579&scope=audio,offline&redirect_uri=http://ttitt.ru/auth/&v=5.2&response_type=token"

#define API_URL @""

@implementation vkAPI


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
    [self alertSheet];
}

-(void) parseAccessTokenAndUserIdFormString:(NSString *)tokenStr{
    
    NSMutableDictionary *tokenDic=[self parseStringURL:tokenStr];
    
    if (![tokenDic objectForKey:@"access_token"])
        return;
    
    if (![tokenDic objectForKey:@"user_id"])
        return;
    
    [[[NSApp delegate] window] makeKeyWindow];
    [[[NSApp delegate] window] makeMainWindow];

    [NSApp endSheet:[self.alert window]];
    [[self.alert window]close];
    self.alert=nil;

    [self.delegate finishAuth:[tokenDic objectForKey:@"access_token"]
                      user_id:[[tokenDic objectForKey:@"user_id"] integerValue]];

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
            NSLog(@"%@",response);
        }
        
        return NO;//Error
    }
    
    return YES;//Success
}


-(BOOL) account_setOffline:(NSString *)token {
    NSString * method=@"account.setOffline";
    NSString * params = @"&v=5.3&";
    id response=[self requestAPI:method parametesForMethod:params token:token];
    return [self checkForErrorResponse:response];
}


-(BOOL) requestAPIVkRemoveTrack:(NSString *)token
                       owner_id:(NSString *)owner_id
                        idTrack:(NSString *)idTrack{
    
    NSString * q = [NSString stringWithFormat:@"&owner_id=%@&audio_id=%@&v=5.2&", owner_id ,idTrack];
    
    id response=[self requestAPI:@"audio.delete" parametesForMethod:q token:token];
    
    return [self checkForErrorResponse:response];
}


-(BOOL) requestAPIVkAddTrack:(NSString *)token
                    owner_id:(NSString *)owner_id
                     idTrack:(NSString *)idTrack {
    
    NSString * q = [NSString stringWithFormat:@"&owner_id=%@&audio_id=%@&v=5.2&", owner_id , idTrack];
    
    id response=[self requestAPI:@"audio.add" parametesForMethod:q token:token];
    
    return [self checkForErrorResponse:response];
}


-(id) requestAPIVkSearch:(NSString*)token
             searchQuery:(NSString *)searchQuery {
    
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


- (void)alertSheet{
    //Create alert
    if (!self.alert) {
    
    self.alert=[NSAlert alertWithMessageText:@"Authorization is required"
                               defaultButton:@"Login"//0
                             alternateButton:@"Cancel"//1
                                 otherButton:@"Sing Up"//-1
                   informativeTextWithFormat:@"Please Login or Sign Up with vk.com"];
    
    
    
        [[[self.alert buttons] objectAtIndex:0] setTarget:self];
        [[[self.alert buttons] objectAtIndex:0] setAction:@selector(login)];
    
        [[[self.alert buttons] objectAtIndex:1] setTarget:self];
        [[[self.alert buttons] objectAtIndex:1] setAction:@selector(signup)];
    
        [[[self.alert buttons] objectAtIndex:2] setTarget:self];
        [[[self.alert buttons] objectAtIndex:2] setAction:@selector(cancel)];
        
    }
    
    //Start alert
    [self.alert beginSheetModalForWindow:[[NSApp delegate] window]
                           modalDelegate:self
                          didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:)
                             contextInfo:nil];
}

- (void) alertDidEnd:(NSAlert *)alert
          returnCode:(NSInteger)returnCode
         contextInfo:(void *)contextInfo{
    NSLog(@"The return code was %li ",returnCode);
}

-(void)login{ NSLog(@"Login");
    [NSWorkspace.sharedWorkspace openURL:[NSURL URLWithString:kAuthURL]];
}

-(void)signup{ NSLog(@"Singup");
    [NSWorkspace.sharedWorkspace openURL:[NSURL URLWithString:@"http://vk.com/"]];
}

-(void)cancel{ NSLog(@"Cancel");
    [[[NSApp delegate] window] close];
    [NSApp endSheet:[self.alert window]];
    [[self.alert window]close];
    self.alert=nil;
}
@end
