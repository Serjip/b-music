//
//  LastfmAPI.h
//  b-music
//
//  Created by Sergey P on 24.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LastfmAPI : NSObject

-(id)track_getInfo:(NSString *) artist title:(NSString *)title;
-(NSImage*)getImageWithArtist:(NSString *) artist title:(NSString *)title size:(NSInteger)size;
-(void) authorize;

@end
