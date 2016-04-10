//
//  BMRequestManager.h
//  b-music
//
//  Created by Sergey P on 31.03.16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMRequestManager : NSObject

- (void)tracksWithCount:(NSUInteger)count offset:(NSUInteger)offset completion:(void (^) (NSArray *tracks, NSError *error))callback;

@end

extern NSString * const BMRequestManagerErrorDomain;
