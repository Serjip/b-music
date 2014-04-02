//
//  SheetWindowController.m
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

#import "SheetWindowController.h"

@interface SheetWindowController ()

@end

@implementation SheetWindowController{
    SEL _someMethod;
}

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
            [_delegate cancelSheet:res[@"access_token"] user_id:[res[@"user_id"] integerValue] execute:_someMethod];
        }else if (res[@"success"]){
            [_delegate cancelSheet:nil user_id:0 execute:_someMethod];
        }
        
        [_delegate cancelSheet:nil user_id:0 execute:_someMethod];
    }
}
- (void)windowDidLoad
{
    [super windowDidLoad];
    NSLog(@"Windows did load");
}

-(void) loadURL:(NSString *) URLsring execute:(SEL)someFunc{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLsring]];
    [self.webview.mainFrame loadRequest:request];
    _someMethod=someFunc;
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
    [_delegate cancelSheet:nil user_id:0 execute:nil];
}
- (IBAction)signup:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://vk.com/"]];
}
@end
