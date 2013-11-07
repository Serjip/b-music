//
//  LastfmAPI.m
//  b-music
//
//  Created by Sergey P on 24.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import "LastfmAPI.h"
#define API_URL @"http://ws.audioscrobbler.com/2.0/"
#define API_KEY @"2eae06b8e133096849f10006f4da696a"
#define AuthURL @"http://www.last.fm/api/auth/?api_key=2eae06b8e133096849f10006f4da696a"

@implementation LastfmAPI

-(id)requestAPILastfm:(NSString*)method param:(NSString*)param{
    NSString *stringURL=[NSString stringWithFormat:@"%@?method=%@&api_key=%@&format=json&%@" , API_URL , method , API_KEY , param];
    stringURL=[stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [[NSURL alloc] initWithString:stringURL];
    NSData *returnedData = [[NSData alloc] initWithContentsOfURL:url];
    NSError *error = nil;
    id object = [NSJSONSerialization
                 JSONObjectWithData:returnedData
                 options:0
                 error:&error];
    if (error) { /* JSON was malformed, act appropriately here */ }
    NSLog(@"LAST FM %@",object);
    return object;
}


-(id)track_getInfo:(NSString *) artist title:(NSString *)title{
    id obj = [self requestAPILastfm:@"track.getInfo" param:[NSString stringWithFormat:@"&autocorrect=1&artist=%@&track=%@",artist,title]];
    return obj;
}


-( NSImage * )getImageWithArtist:(NSString *) artist title:(NSString *)title size:(NSInteger)size {
    id obj=[self track_getInfo:artist title:title];
    id imageObj = [[[obj objectForKey:@"track"] objectForKey:@"album"] objectForKey:@"image"];
    NSString * stringImageURL = [[imageObj objectAtIndex:size]objectForKey:@"#text"];
    NSLog(@"%@",stringImageURL);
    return [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:stringImageURL]];
}

-(void) authorize{
    [NSWorkspace.sharedWorkspace openURL:[NSURL URLWithString:AuthURL]];
}

@end
