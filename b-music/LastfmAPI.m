//
//  LastfmAPI.m
//  b-music
//
//  Created by Sergey P on 24.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "LastfmAPI.h"

@implementation LastfmAPI

-(id)requestAPILastfm:(NSString*)method param:(NSString*)param{
    
    NSString * api_key=@"2eae06b8e133096849f10006f4da696a";
    NSString * src=@"http://ws.audioscrobbler.com/2.0/";
    
    NSString *stringURL=[NSString stringWithFormat:@"%@?method=%@&api_key=%@&format=json&%@" , src , method , api_key , param];
    
    stringURL=[stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [[NSURL alloc] initWithString:stringURL];
    NSData *returnedData = [[NSData alloc] initWithContentsOfURL:url];
    NSError *error = nil;
    id object = [NSJSONSerialization
                 JSONObjectWithData:returnedData
                 options:0
                 error:&error];
    if(error) { /* JSON was malformed, act appropriately here */ }
    
    //NSLog(@"LAST FM %@",);
    return [[[object objectForKey:@"track"] objectForKey:@"album"] objectForKey:@"image"];
    
}


-(NSString*)getImageStringURL:(NSString *) artist title:(NSString *)title {
    
    id img=[self requestAPILastfm:@"track.getInfo" param:[NSString stringWithFormat:@"&autocorrect=1&artist=%@&track=%@",artist,title]];
    
    NSString *stringURL=[[img objectAtIndex:3]objectForKey:@"#text"];
    NSLog(@"%@",stringURL);
    
    return stringURL;
}

@end
