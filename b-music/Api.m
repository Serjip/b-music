//
//  Api.m
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "Api.h"

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

-(BOOL)checkResponse:(id)response{
    
    
    return YES;
}

//-(BOOL)checkResponseToError:(id)response{
//    
//    if([response objectForKey:@"error"]){
//        
//        
//        NSLog(@"%@",[response objectForKey:@"error"]);
//        if ([[[response objectForKey:@"error"] objectForKey:@"error_code"] isEqual:@(17)]) {
//            
//            
//            [self disconnectMI];
//            [self.window orderOut:nil];
//            
//            NSLog(@"LOcal monitor %@",_localMonitorForEvents);
//            
//            if(_localMonitorForEvents)
//            {
//                [NSEvent removeMonitor:_localMonitorForEvents];
//                _localMonitorForEvents=nil;
//                NSLog(@"Remove monitor");
//            }
//            
//            //Start auth
//            if (!self.wc) {
//                self.wc=[[WindowController alloc] initWithWindowNibName:@"WindowController"];
//            }
//            
//            [self.wc showWindow:self];
//            
//            [self.wc goToURL:[[response objectForKey:@"error"] objectForKey:@"redirect_uri"]];
//            
//            [self.wc addObserver:self
//                      forKeyPath:@"isCapFinish"
//                         options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
//                         context:@"isCapFinish"];
//            
//            return YES;
//            
//        }else{
//            
//            NSAlert * alert=[NSAlert alertWithMessageText:NSLocalizedString(@"Error", @"Error")
//                                            defaultButton:NSLocalizedString(@"ok", @"ok")
//                                          alternateButton:nil
//                                              otherButton:nil
//                                informativeTextWithFormat:NSLocalizedString(@"alertErrorMessageExpired", @"message")];
//            
//            
//            [alert beginSheetModalForWindow:self.window
//                              modalDelegate:self
//                             didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:)
//                                contextInfo:nil];
//            
//            return YES;
//        }
//        
//        
//    }
//    return NO;
//}
@end
