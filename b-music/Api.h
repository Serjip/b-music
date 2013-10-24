//
//  Api.h
//  b-music
//
//  Created by Sergey P on 02.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Api : NSObject

-(id) requestAPI:(NSString*)method parametesForMethod:(NSString*)param token:(NSString*)token;

@end
