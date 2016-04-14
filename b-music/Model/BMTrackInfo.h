//
//  BMTrackInfo.h
//  b-music
//
//  Created by Sergey P on 14.04.16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMTrackInfo : NSObject

@property (strong, nonatomic, readonly) NSURL *trackURL;
@property (strong, nonatomic, readonly) NSString *trackName;

- (instancetype)initWithServerResponse:(NSDictionary *)response;

@end
