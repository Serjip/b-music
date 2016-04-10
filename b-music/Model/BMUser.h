//
//  BMUser.h
//  b-music
//
//  Created by Sergey P on 10.04.16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMUser : NSObject

@property (assign, nonatomic, readonly, getter=isAuthorized) BOOL authorized;

@end
