//
//  LastfmAPI.h
//  b-music
//
//  Created by Sergey P on 24.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LastfmAPI : NSObject

-(id) requestAPILastfm:(NSString*)method param:(NSString*)param;

-(NSString*)getImageStringURL:(NSString *) artist title:(NSString *)title;

@end
