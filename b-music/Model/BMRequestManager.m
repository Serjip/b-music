//
//  BMRequestManager.m
//  b-music
//
//  Created by Sergey P on 31.03.16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

#import "BMRequestManager.h"
#import <AFNetworking.h>

@implementation BMRequestManager {
@private
    AFHTTPRequestOperationManager *_vkManager;
    dispatch_queue_t _processing_queue;
    NSString *_accessToken;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _accessToken = @"533bacf01e11f55b536a565b57531ac114461ae8736d6506a3";
        _processing_queue = dispatch_queue_create("com.ttitt.b-music.queue", DISPATCH_QUEUE_SERIAL);
        NSURL *URL = [NSURL URLWithString:@"https://api.vk.com/method/"];
        _vkManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:URL];
        _vkManager.completionQueue = _processing_queue;
    }
    return self;
}

- (void)audioWithCompletion:(void (^) (NSArray *tracks, NSError *error))callback
{
    NSParameterAssert(callback);
    
    NSDictionary *params = @{@"v": @"5.50"};
    
    [self GET:@"audio.get" params:params completion:^(id response, NSError *error) {
        
        callback(response, error);
    
    }];
}

- (void)GET:(NSString *)URLString params:(NSDictionary *)params completion:(void(^)(id response, NSError *error))callback
{
    NSMutableDictionary *p = [[NSMutableDictionary alloc] initWithDictionary:params];
    [p setValue:_accessToken forKey:@"access_token"];
    
    [_vkManager GET:URLString parameters:p success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject) {
            <#statements#>
        }

        
    
        callback(responseObject, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        callback(nil, error);
    
    }];
}

@end
