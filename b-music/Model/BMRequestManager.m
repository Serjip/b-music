//
//  BMRequestManager.m
//  b-music
//
//  Created by Sergey P on 31.03.16.
//  Copyright © 2016 Sergey Popov. All rights reserved.
//

#import "BMRequestManager.h"

#import <SSKeychain/SSKeychain.h>
#import <AFNetworking/AFNetworking.h>

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

- (void)tracksWithCount:(NSUInteger)count offset:(NSUInteger)offset completion:(void (^) (NSArray *tracks, NSError *error))callback
{
    NSParameterAssert(callback);
    
    NSDictionary *params = @{@"count": @(count),
                             @"offset": @(offset),
                             @"v": @"5.50"};
    
    [self GET:@"audio.get" params:params completion:^(NSDictionary *rsp, NSError *error) {
        
        NSArray *rawTracks = [rsp valueForKeyPath:@"response.items"];
        
//        if ()
//        {
//            for (NSDictionary *rawTrack in rawTracks)
//            {
//                
//            }
//        }
        
        callback(rsp, error);
    
    }];
}

- (void)GET:(NSString *)URLString params:(NSDictionary *)params completion:(void(^)(NSDictionary *rsp, NSError *error))callback
{
    NSMutableDictionary *p = [[NSMutableDictionary alloc] initWithDictionary:params];
    [p setObject:_accessToken forKey:@"access_token"];
    
    [_vkManager GET:URLString parameters:p success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError *error;
        BOOL responseIsValid = NO;
        
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            if ([responseObject objectForKey:@"error"])
            {
                NSNumber *code = [responseObject valueForKeyPath:@"error.error_code"];
                NSString *message = [responseObject valueForKeyPath:@"error.error_msg"];
                
                if ([code isKindOfClass:[NSNumber class]] && [message isKindOfClass:[NSString class]])
                {
                    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : message};
                    error = [NSError errorWithDomain:BMRequestManagerErrorDomain code:code.integerValue userInfo:userInfo];
                }
            }
            else
            {
                responseIsValid = YES;
            }
        }
        
        if (! responseIsValid && ! error)
        {
            NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : NSLocalizedString(@"Invalid server response", nil)};
            error = [NSError errorWithDomain:BMRequestManagerErrorDomain code:500 userInfo:userInfo];
        }
        
        callback(responseObject, error);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        callback(nil, error);
    
    }];
}

@end

NSString * const BMRequestManagerErrorDomain = @"BMRequestManagerErrorDomain";
