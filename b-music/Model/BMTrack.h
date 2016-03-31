//
//  BMTrack.h
//  b-music
//
//  Created by Sergey P on 31.03.16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMTrack : NSObject

@property (assign, nonatomic, readonly) NSUInteger identifier;
@property (strong, nonatomic, readonly) NSString *artist;
@property (strong, nonatomic, readonly) NSString *title;
@property (assign, nonatomic, readonly) NSUInteger duration;
@property (strong, nonatomic, readonly) NSURL *URL;

@end
