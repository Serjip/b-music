//
//  b_musicTests.m
//  b-musicTests
//
//  Created by Sergey P on 01.10.13.
//  Copyright (c) 2013 Sergey P. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BMRequestManager.h"

@interface b_musicTests : XCTestCase

@property (nonatomic, strong) BMRequestManager *manager;

@end

@implementation b_musicTests

- (void)setUp
{
    [super setUp];
    _manager = [BMRequestManager new];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testGetAudioTracks
{
    XCTestExpectation *ex = [self expectationWithDescription:@"High Expectations"];
    
    [self.manager tracksWithCount:10 offset:0 completion:^(NSArray *tracks, NSError *error) {
        
        NSLog(@"%@", tracks);
        XCTAssert(! error);
        [ex fulfill];
        
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error)
        {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

@end
