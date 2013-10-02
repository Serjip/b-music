//
//  SheetWindowController.m
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "SheetWindowController.h"
#define kAuthURL @"https://oauth.vk.com/authorize?client_id=3796579&scope=audio,offline&redirect_uri=https://oauth.vk.com/blank.html&display=wap&v=5.2&response_type=token"

@interface SheetWindowController ()

@end

@implementation SheetWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}
-(void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame{
    NSString * URLstring=[NSString stringWithString:[self.webview mainFrameURL].description];
    NSLog(@"Frame URL%@",URLstring);
    NSRange range = [URLstring rangeOfString:@"https://oauth.vk.com/blank.html#"];
    if (range.length!=0){
        NSDictionary *res=[ self parseStringURL:[URLstring componentsSeparatedByString:@"#"][1]];
        NSLog(@"Parse url %@",res);
        if (res[@"access_token"]) {
            [_delegate cancelSheet:res[@"access_token"] user_id:[res[@"user_id"] integerValue]];
        }
    }
}
- (void)windowDidLoad
{
    [super windowDidLoad];
    //[self clearCookie];
    [self loadURL:kAuthURL];
}
-(void) loadURL:(NSString *) URLsring{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLsring]];
    [self.webview.mainFrame loadRequest:request];
}

-(void)clearCookie{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        NSString* domainName = [cookie domain];
        NSRange domainRange = [domainName rangeOfString:@"vk.com"];
        if(domainRange.length > 0) {
            [storage deleteCookie:cookie];
        }
    }
    NSLog(@"Clear cookies");
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
-(IBAction)cancel:(id)sender{NSLog(@"CancelSheet");
    [_delegate cancelSheet:nil user_id:0];
}
@end
